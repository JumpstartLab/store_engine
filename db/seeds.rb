# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

products = Product.create([{ title: 'Stiletto', 
                       description: 'High lady shoe', 
                             price: 125.00, 
                        image_link: "http://ml-explode.com/wp-content/uploads/2012/04/red-stilleto.jpg"},
                        { title: 'Rain boot', 
                       description: 'it keeps your feet dry.', 
                             price: 299.00, 
                        image_link: "http://www.outblush.com/women/images/2008/03/tretorn-skerry-rain-boot.jpg"},
                        { title: 'Toe shoe', 
                       description: "for those people who have smelly feet but don't like shoes", 
                             price: 10.00, 
                        image_link: "http://s3.amazonaws.com/VibramFiveFingers/m108-hero.jpg"},
                        { title: 'Sneaker', 
                       description: 'Old faithful', 
                             price: 99.00, 
                        image_link: "http://www.shoewawa.com/assets_c/2011/09/back-to-the-future-shoes-thumb-435x333-120222.jpg"}])

admin_user = User.new(  full_name: "Chad Fowler",
                        password: "hungry",
                        password_confirmation: "hungry",
                        email: "chad.fowler@livingsocial.com",
                        username: "SaxPlayer" )

admin_user.admin = true
admin_user.save

User.create(  full_name: "Matt Yoho",
              password: "hungry",
              password_confirmation: "hungry",
              email: "matt.yoho@livingsocial.com" )

User.create(  full_name: "Jeff Casimir",
              password: "hungry",
              password_confirmation: "hungry",
              email: "jeff.casimir@livingsocial.com",
              username: "j3" )

orders = Order.create([{ status: "pending", total_price: 5000},
                      { status: "shipped", total_price: 10000}])

order_items = OrderItem.new( 
  quantity: 10, 
  unit_price: 50, 
  product_id: products.first.id,
  order_id: orders.first.id )

order_items.save

order_items = OrderItem.create([{ quantity: 10, 
  unit_price: 50, 
  product_id: products[2].id,
  order_id: orders.first.id}])

category = Category.create( title: "Male")
category = Category.create( title: "Female")

