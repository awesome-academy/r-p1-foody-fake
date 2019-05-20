class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant

  scope :ordered_by_created_at, -> {order created_at: :desc}
end
