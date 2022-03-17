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
    @order.stripe_charge_id= PayPal.to_s
    @order.save
    add_line_items_to_order(@order)
    # @order.save

  end

  def PayPal
    @payment = PayPal::SDK::REST::Payment.new({
      intent: "sale",
      payer: {
        payment_method: "paypal" },
      redirect_urls: {
        return_url: success_orders_url,
        cancel_url: root_url },
      transactions: [ {
        amount: {
          total: "<%= current_cart.total_price %>",
          currency: "USD" },
        description: "ExpressBot Payment" } ] } )
    if @payment.create
      redirect_url = @payment.links.find {|link| link.rel == 'approval_url'}
      redirect_to redirect_url.href
      return @payment.id
    else
      redirect_to root_url, notice: @payment.error
    end
  end

  def update_data
    @cart = current_cart
    @line_item = @cart.line_items.find(params[:id])
    @line_item.update_attributes(cart_params)
    @line_items = current_cart.line_items
    @line_item.save
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
