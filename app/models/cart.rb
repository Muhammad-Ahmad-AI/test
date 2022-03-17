class Cart < ApplicationRecord
  belongs_to :user ,  optional: true  # optional: true  =>  user can be nil
  has_many :line_items , as: :line_itemable, dependent: :destroy
  has_many :products, through: :line_items
  before_save :set_subtotal

  def sub_total
    line_items.collect{|line_item| line_item.valid? ? line_item.unit_price*line_item.quantity : 0}.sum
  end

  private

  def set_subtotal
    self[:sub_total] = sub_total
  end
end
