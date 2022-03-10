module ApplicationHelper
  def current_cart
    if !session[:cart_id].nil?
        Cart.find(session[:cart_id])
    else
        Cart.new
    end
end
end
