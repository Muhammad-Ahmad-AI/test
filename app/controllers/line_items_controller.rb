class LineItemsController < ApplicationController
  # before_action :set_line_item, only: %i[ update destroy ]

  def create
    @cart = current_cart
    if user_signed_in?
    @cart.user_id = current_user.id
    end
    @cart.save
    @i=0
    @cart.line_items.each do |line_item|
      if line_item.product_id == cart_params[:product_id].to_i
         line_item.quantity +=1
         line_item.product.decrement!(:quantity)
         line_item.save
         @i=1
      end
    end
    if @i==1
      redirect_to '/products'
    else
    @line_item = @cart.line_items.new(cart_params)
    @line_item.product.decrement!(:quantity)
    @line_item.save
    session[:cart_id] = @cart.id
    redirect_to '/products'
    end
  end

  def update
    @cart = current_cart
    @line_item = @cart.line_items.find(params[:id])
    p_quantity = @line_item.quantity
    # check is the product quantity is enough
    if @line_item.product.quantity >= params[:line_item][:quantity].to_i
      @line_item.update_attributes(cart_params)
      u_quantity = @line_item.quantity
      if p_quantity > u_quantity
        @line_item.product.decrement!(:quantity, u_quantity - p_quantity)
      elsif p_quantity < u_quantity
        @line_item.product.increment!(:quantity, p_quantity - u_quantity)
      end
      # @line_item.update(cart_params)
      # @line_item.product.decrement!(:quantity, p_quantity)
      # @line_item.product.increment!(:quantity, params[:line_item][:quantity].to_i - p_quantity)

    else
      flash[:notice] = 'The product quantity is not enough'
    end
    # @line_item.update_attributes(cart_params)
    # u_quantity = @line_item.quantity
    # if p_quantity > u_quantity
    #   @line_item.product.decrement!(:quantity, u_quantity - p_quantity)
    # elsif p_quantity < u_quantity
    #   @line_item.product.increment!(:quantity, p_quantity - u_quantity)
    # end

    @line_item.save
    redirect_to '/carts'
  end

  def destroy
    @cart = current_cart
    @line_item = current_cart.line_items.find(params[:id])
    @line_item.product.increment!(:quantity, @line_item.quantity)
    @line_item.destroy

    respond_to do |format|
      format.js { render :layout => false }
    end

  end

  private

  def cart_params
    params.require(:line_item).permit(:product_id, :quantity)
  end
end
