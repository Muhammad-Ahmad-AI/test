class LineItemsController < ApplicationController
  # before_action :set_line_item, only: %i[ update destroy ]

  def create
    @cart = current_cart
    @cart.user_id = current_user.id
    @cart.save
    @line_item = @cart.line_items.new(cart_params)
    @line_item.save
    session[:cart_id] = @cart.id

    # if user_signed_in?
    #   @cart.cart_id = current_user.id
    #   @cart.save
    #   @line_item.save
    #   byebug
    #   session[:cart_id] = @cart.id
    # else
    #   session[:cart] = @line_item
    # end
  end

  def update
    @cart = current_cart
    @line_item = @cart.line_items.find(params[:id])
    @line_item.update_attributes(cart_params)
    @line_items = current_cart.line_items
    @line_item.save

  end

  def destroy
    @cart = current_cart
    @line_item = current_cart.line_items.find(params[:id])
    @line_item.destroy
    @line_item.save


    # @cart = current_cart
    # @line_item = @cart.line_items.find()
    # @line_item.destroy
    # @line_items = current_cart.line_items
    # @line_item.save
  end

  private
  # def set_line_item
  #   @line_item = LineItem.find(params[:id])
  # end

  def cart_params
    params.require(:line_item).permit(:product_id, :quantity)
  end
end
