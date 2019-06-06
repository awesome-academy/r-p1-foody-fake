class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant
  has_many :comment_likes, foreign_key: "comment_id", dependent: :destroy
  validates :content, presence: true, length: { maximum: Settings.maximum_comment_content }

  scope :ordered_by_created_at, -> {order created_at: :desc}
end
