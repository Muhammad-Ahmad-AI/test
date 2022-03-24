class OrdersController < ApplicationController
  before_filter :require_login

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end


  def create
    @order = Order.new()
    @order.user_id = current_user.id
    @order.stripe_charge_id= perform_stripe_charge
    @order.save
    add_line_items_to_order(@order)
    # @order.save

  end



  # stripe payment method
  def perform_stripe_charge
    # Amount in cents
    @amount = @current_cart.total_price * 100

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Rails Stripe customer',
      :currency    => 'usd'
    )

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to '/carts'
  end





  def add_line_items_to_order(@order)
    line_item_ids = @current_cart.line_items.pluck(:id)

    LineItem.where(id: line_item_ids).update_all(
      line_itemable_id: @order.id,
      line_itemable_id: 'Order'
    )
    # @current_cart.line_items.each do |item|
    #   item.line_itemable = @order
    #   item.save
    #   @order.save
    # end
  end

  private

  def require_login
    unless current_user
      redirect_to '/login'
    end
  end


end

