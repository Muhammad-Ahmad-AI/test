class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :avatar
  has_many :products
  has_many :orders
  has_many :comments
  has_one :cart
  has_many :line_items, as: :line_itemable
  # after_create :email_user

  def email_user
    UserMailer.welcome_email(self).deliver
  end
end
