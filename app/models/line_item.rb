class LineItem < ApplicationRecord

  belongs_to :product
  belongs_to :line_itemable, polymorphic: true
  before_save :set_unit_price
  before_save :set_total
  validates :product_id, presence: true
  validates :quantity,presence: true, numericality: { greater_than: 0 }
  validates :line_itemable_id, presence: true
  validates :line_itemable_type, presence: true
  validates :total_price, presence: true, numericality: { greater_than: 0 }
  validates :unit_price, presence: true,  numericality: { greater_than: 0 }

  def unit_price
      if persisted?
          self[:unit_price]
      else
          product.price
      end
  end


  def total
      unit_price*quantity
  end


  private

  def set_unit_price
      self[:unit_price] = unit_price
  end

  def set_total
      self[:total_price] = total * quantity
  end
end
