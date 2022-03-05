module ApplicationHelper
  def current_order
    if !session[:order_id].nil?
        Cart.find(session[:order_id])
    else
        Cart.new
    end
end
end
