class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :food

  validates :quantity, numericality: { greater_than: Settings.minimum_quantity, less_than_or_equal_to: Settings.maximum_quantity }

  def update_quantity quantity
    self.update_attributes quantity: quantity
  end

end
