Fabricator(:line_item, :class_name => LineItem) do
  order_id { (rand * 100).to_i }
  price { BigDecimal.new((rand * 1000), 2) }
  quantity { 1 }
  product_id { (rand * 100).to_i }
end