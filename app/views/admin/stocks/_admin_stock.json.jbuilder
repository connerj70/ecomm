json.extract! admin_stock, :id, :size, :amount, :product_id, :created_at, :updated_at
json.url admin_stock_url(admin_stock, format: :json)
