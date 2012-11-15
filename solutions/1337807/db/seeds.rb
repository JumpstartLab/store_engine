100.times { Fabricate(:product, :photo => 'http://1337807.com/images/megaman.gif') }
10.times { Fabricate(:category) }

Product.all.each do |product|
  Category.all.sample.add_product(product)
end

20.times do
  Product.all.sample.add_category(Category.all.sample)
end

["pending", "cancelled", "paid", "shipped", "returned"].each do |status|
  3.times { Fabricate(:order, :status => status) }
end

User.create(
  :name => 'Matt Yoho',
  :email => 'demo10+matt@jumpstartlab.com',
  :password => 'hungry'
)

User.create(
  :name => 'Jeff',
  :email => 'demo10+jeff@jumpstartlab.com',
  :password => 'hungry',
  :username => 'j3'
)

User.create(
  :name => 'Chad Fowler',
  :email => 'demo10+chad@jumpstartlab.com',
  :password => 'hungry',
  :username => 'SaxPlayer'
).set_role('admin')
