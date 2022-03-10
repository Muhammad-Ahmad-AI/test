class ShopsController < ApplicationController
  def index
    @products = Product.all

    @cart_item = current_cart.line_items.new
  end

  def show
    @product = Product.find(params[:id])
  end
end
