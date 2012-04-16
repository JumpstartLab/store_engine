Fabricator(:order, :class_name => "Order") do
  id { sequence }
  shipping_address 
  billing_address
  status
  order_items { [Fabricate(:product), Fabricate(:product)] }
end
