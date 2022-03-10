class Product < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :orders
  has_many :carts
  has_many :carts, through: :line_items
  has_many :line_items , as: :line_itemable
  has_many :orders, through: :line_items
  has_one_attached :main_image
  has_many_attached :other_images
end
