Fabricator(:line_item, :class_name => LineItem) do
  order_id { (rand * 100).to_i }
  price { (rand * 1000).to_i }
  quantity { (rand * 10).to_i }
  product_id { (rand * 100).to_i }
end