# This file should contain all the record creation
# needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed
# (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
matt = User.create(:first_name => "Matt",
                   :last_name => "Yoho",
                   :email => "demo07+matt@jumpstartlab.com",
                   :password => "hungry")

jeff = User.create(:first_name => "Jeff",
                   :last_name => "",
                   :email => "demo07+jeff@jumpstartlab.com",
                   :password => "hungry",
                   :display_name => "j3")

chad = User.new(:first_name => "Chad",
                   :last_name => "Fowler",
                   :email => "demo07+chad@jumpstartlab.com",
                   :password => "hungry",
                   :display_name => "SaxPlayer")

chad.admin = true
chad.save

# active products
chair = Product.create(:title => "Sweet chair",
        :description => "This is a great chair",
        :price => "5.00",
        :remote_image_url =>
        "http://ecx.images-amazon.com/images/I/31pVwh3qNvL._SL500_AA300_.jpg")

desk = Product.create(:title => "Amazing desk",
        :description => "This is the coolest desk",
        :price => "20.00",
        :remote_image_url =>
        "http://www.vintagedanishmodern.com/products/87381.jpg")

clock = Product.create(:title => "Clock",
        :description => "Crazy expensive Banker's Clock",
        :price => "400.00",
        :remote_image_url =>
        "http://ecx.images-amazon.com/images/I/316DTOGbiRL._SL500_AA300_.jpg")

stove = Product.create(:title => "Viking Range",
        :description => "The best cooking experience ever",
        :price => "5200.00",
        :remote_image_url =>
        "http://ecx.images-amazon.com/images/I/41XtFmar9UL._SL500_AA300_.jpg")

#inactive product
table = Product.create(:title => "Great table",
        :description => "This is the sweetest table",
        :price => "10.00",
        :remote_image_url =>
        "http://ecx.images-amazon.com/images/I/31lRJMSUDOL._SL500_AA300_.jpg",
        :retired => true)

# create categories
furniture = Category.create(:name => "Furniture")
accessory = Category.create(:name => "Accessories")
appliance = Category.create(:name => "Appliances")

# fill categories

accessory.products << clock
furniture.products << [chair, desk, table]
appliance.products << stove

# make orders
20.times do |i|
  Fabricate(:order, :user_id => rand(3)+1)
  OrderProduct.create(:quantity => rand(10)+1,
                      :product_id => rand(4)+1,
                      :order_id => i+1)
end

# make billing addresses
3.times do
  Fabricate(:order, :billing_address_id => rand(3)+1)
end

# make shipping addresses
2.times do
  Fabricate(:order, :shipping_address_id => rand(5)+1)
end

# make addresses
Fabricate(:address, :id => 1)
Fabricate(:address, :id => 2)
Fabricate(:address, :id => 3)
Fabricate(:address, :id => 4)
Fabricate(:address, :id => 5)