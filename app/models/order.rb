class Order < ApplicationRecord
  belongs_to :user
  enum status: {  placed: 0,
                  processing: 1,
                  shipped: 2,
                  delivered: 3,
                  canceled: 4,
                  returned: 5
                }
  has_many :line_items, as: :line_itemable, dependent: :destroy
  has_many :products, through: :line_items

  before_save :set_total
  before_save :set_status
  
  # after_create :email_user

  def email_user
    UserMailer.order_email(self).deliver
  end

  def set_status
    self[:status] = :placed
  end

  def sub_total
    line_items.collect{|line_item| line_item.valid? ? line_item.unit_price*line_item.quantity : 0}.sum
  end

  private

  def set_total
    self[:sub_total] = sub_total
  end

end
