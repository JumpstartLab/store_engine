Fabricator(:order_item, :class_name => "order_item") do
  quantity { 10 }
  price { "10.00" }
  product!
end
