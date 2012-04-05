# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

products = Product.create([{ title: 'Stiletto', 
                       description: 'High lady shoe', 
                             price: 10000, 
                        image_link: "http://ml-explode.com/wp-content/uploads/2012/04/red-stilleto.jpg"},
                        { title: 'Rain boot', 
                       description: 'it keeps your feet dry.', 
                             price: 5000, 
                        image_link: "http://www.outblush.com/women/images/2008/03/tretorn-skerry-rain-boot.jpg"},
                        { title: 'Toe shoe', 
                       description: "for those people who have smelly feet but don't like shoes", 
                             price: 200, 
                        image_link: "http://s3.amazonaws.com/VibramFiveFingers/m108-hero.jpg"},
                        { title: 'Sneaker', 
                       description: 'Old faithful', 
                             price: 10000, 
                        image_link: "http://www.shoewawa.com/assets_c/2011/09/back-to-the-future-shoes-thumb-435x333-120222.jpg"}])

orders = Order.create([{ status: "pending", total_price: 5000},
                      { status: "shipped", total_price: 10000}])

order_items = OrderItem.create([{ quantity: 10, 
  unit_price: 50, 
  product_id: products.first.id,
  order_id: orders.first.id}])

order_items = OrderItem.create([{ quantity: 10, 
  unit_price: 50, 
  product_id: products[2].id,
  order_id: orders.first.id}])

