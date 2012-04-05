Fabricator(:cart_item, :class_name => "CartItem") do
  id { sequence }
  quantity { 3 }
  price { 10000 }
end