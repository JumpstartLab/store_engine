Fabricator(:cart_item, :class_name => "CartItem") do
  id { sequence }
  quantity { 3 }
  price_cents { Money.new(10000, "USD") }
end