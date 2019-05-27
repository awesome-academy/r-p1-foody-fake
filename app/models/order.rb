class Order < ApplicationRecord
  # belongs_to :restaurant
  has_many :order_details, foreign_key: "order_id", dependent: :destroy
  belongs_to :user

  def self.get_order_id
    Order.last.id + 1
  end

  def get_order_details
    @order_details = self.order_details
  end

  def get_food_names_images
    get_order_details
    food_ids = @order_details.pluck(:food_id)
    food_orderd = Food.where("id IN (?)", food_ids)
    id_to_name_image = food_orderd.map{ |c| [c.id, [c.name, c.image]] }.to_h
    return id_to_name_image
  end

  def get_total_value
    @order_details = self.order_details
    @order_details.map{ |c| (c.price * c.quantity) }.map(&:to_i).reduce(Settings.default_value_order, :+)
  end
end
