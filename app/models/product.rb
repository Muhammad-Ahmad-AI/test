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
  validates :name, presence: true
  validates :description, presence: true
  validates :quantity, presence: true
  validates :price, presence: true
  validates :main_image, presence: true

  def self.search(search)
    if search
      # Product.find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
      where('name LIKE ?', "%#{search}%")
    else
      all
    end
  end

  def image_resize
    return self.main_image.variant(resize: '300x300!').processed
  end

  def image_resize_other
    return self.other_images.variant(resize: '300x300!').processed
  end

end
