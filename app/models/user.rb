class User < ApplicationRecord

  has_many :ratings, foreign_key: "user_id", dependent: :destroy
  has_many :comments, foreign_key: "user_id", dependent: :destroy
  has_many :comment_likes, foreign_key: "user_id", dependent: :destroy
  has_many :orders, foreign_key: "user_id", dependent: :destroy

  attr_accessor :remember_token, :activation_token, :reset_token

  before_save :downcase_email
  before_create :create_activation_digest

  validates :name, presence: true, length: { maximum: Settings.maximum_length_name }
  validates :email, presence: true, length: { maximum: Settings.maximum_length_email }, format: { with: Settings.valid_email_regex }, uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: { minimum: Settings.minimum_length_password }, allow_nil: true

  has_secure_password

  def check_type type
    type_of_user == type
  end

  def get_order_id
    order = Order.find_by(user_id: self.id, status: "pending")
    order ? order.id : nil
  end

  def get_restaurant
    return unless self.check_type "manager"
    Restaurant.find_by(manager_id: self.id)
  end

  def activate
    update_attributes activated_at: Time.zone.now, activated: true
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def create_activation_digest
    self.activation_token  = User.new_token
    self.activation_digest = User.digest activation_token
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_attributes reset_sent_at: Time.zone.now, reset_digest: User.digest(reset_token)
  end

  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def User.digest string
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
      BCrypt::Engine.cost
    BCrypt::Password.create string, cost: cost
  end

  def like_comment comment_id
    comment_likes.pluck(:comment_id).include?(comment_id) ? true : false
  end

  def password_reset_expired?
    reset_sent_at < Settings.expire_hour.hours.ago
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attributes remember_digest: User.digest(remember_token)
  end

  def authenticated?(attribute, token)
    digest = self.send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
    update_attributes remember_digest: nil
  end

  private
    def downcase_email
      email.downcase!
    end
end
