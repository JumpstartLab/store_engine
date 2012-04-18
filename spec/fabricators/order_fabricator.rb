Fabricator(:order) do
  user! { Fabricate(:user) }
  status 'pending'
  billing_address '123 foo street, bar, mn, 82341'
  email_address 'fillintheblank@hahaha.com'
  credit_card '4444 1111 1111 1111'
  after_create do |order|
    2.times do
      order.order_items.create!(product_id: Fabricate(:product).id, quantity: 1)    
    end
  end

end