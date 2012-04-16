Fabricator(:order) do
  user! { Fabricate(:user) }
  status 'pending'
  after_create do |order|
    2.times do
      order.order_items.create!(product_id: Fabricate(:product).id, quantity: 1)    
    end
  end

end