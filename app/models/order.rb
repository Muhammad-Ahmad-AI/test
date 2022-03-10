class Order < ApplicationRecord
  belongs_to :user
  enum status: {  place: 0,
                  processing: 1,
                  shipped: 2,
                  delivered: 3,
                  canceled: 4,
                  returned: 5
                }
  has_many :line_items, as: :line_itemable, dependent: :destroy
  has_many :products, through: :line_items

end
