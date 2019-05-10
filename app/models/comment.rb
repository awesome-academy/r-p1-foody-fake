class Comment < ApplicationRecord
  belongs_to :restaurant
  belongs_to :user
  belongs_to :comment
end
