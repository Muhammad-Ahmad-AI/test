json.extract! product, :id, :name, :description, :picture, :quantity, :price, :user_id, :created_at, :updated_at
json.url product_url(product, format: :json)
