class CartsController < ApplicationController
  def show
    @cart_items = current_cart.line_items
    # if Cart.exists?(session[:cart_id])
    #   @cart_items = current_cart.line_items
    # else
    #   @cart_items = session[:cart]
    #   # @cart_items = current_cart.line_items
    # end
  end
end
