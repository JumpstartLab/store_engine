
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Product.destroy_all
Order.destroy_all
LineItem.destroy_all
BillingMethod.destroy_all
ShippingAddress.destroy_all
User.destroy_all
Category.destroy_all
ProductCategorization.destroy_all

matt = User.create(full_name: 'Matt Yoho',
  email_address: 'demoXX+matt@jumpstartlab.com', display_name: '',
  password: 'hungry')
jeff = User.create(full_name: 'Jeff Casimir',
  email_address: 'demoXX+jeff@jumpstartlab.com',
  display_name: 'j3', password: 'hungry')
chad = User.create(full_name: 'Chad Fowler',
 email_address: 'demoXX+chad@jumpstartlab.com',
 display_name: 'SaxPlayer', password: 'hungry')
chad.update_attribute(:admin, true)


['Bikes', 'Shoes', 'Helmets', 'Tires', 'Accessories' ].each do |cat|
  Category.create(name: cat)
end

products = []
#Bikes
products << Product.create(title: 'Zoomer', description: 'fast and affordable',
 price: 999.99, photo_url: 'http://swipe.swipelife.netdna-cdn.com/wp-content/uploads/2009/08/trek-urban-bikes-main.jpg',
 category_ids: [Category.find_by_name('Bikes').id.to_s])
products << Product.create(title: 'Boomer', description: 'fast and reliable',
 price: 1500, photo_url: 'http://swipe.swipelife.netdna-cdn.com/wp-content/uploads/2009/08/trek-urban-bikes-main.jpg',
 category_ids: [Category.find_by_name('Bikes').id.to_s])
products << Product.create(title: 'Racer', description: 'dead fast',
 price: 2000, photo_url: 'http://www.beautifullife.info/wp-content/uploads/2010/09/04/04.jpg',
 category_ids: [Category.find_by_name('Bikes').id.to_s])
products << Product.create(title: 'Cruiser', description: 'enjoys the road',
 price: 1499.99, photo_url: 'http://www.thecycler.net/photos/urban_outfitters_1-w600h361.jpg',
 category_ids: [Category.find_by_name('Bikes').id.to_s])
products << Product.create(title: 'Commuter', description: 'gets you to work',
 price: 1799.50, photo_url: 'http://yatzer.com/assets/Article/2312/images/Bamboocycle-A-Sustainable-Urban-Bicycle-yatzer-6.jpg',
 category_ids: [Category.find_by_name('Bikes').id.to_s])
#Shoes
products << Product.create(title: 'Razor', description: 'so comfortable',
 price: 99.99, photo_url: 'http://www.extremesupply.com/Merchant2/graphics/00000001/600x600/sidi/sidi_bicycle_shoes/sidi_hydro_gtx_shoes.jpg',
 category_ids: [Category.find_by_name('Shoes').id.to_s])
products << Product.create(title: 'Blader', description: 'perfect fit',
 price: 50, photo_url: 'http://recklesscognition.files.wordpress.com/2009/01/51fe2hm5cml_sidi-blaze-womens-mountain-bike-shoes-steel_.jpg',
 category_ids: [Category.find_by_name('Shoes').id.to_s])
products << Product.create(title: 'Tesler', description: 'strong and durable',
 price: 150, photo_url: 'http://www.bicyclebuys.com/productimages/DITRMTBM8PART.jpg',
 category_ids: [Category.find_by_name('Shoes').id.to_s])
products << Product.create(title: 'FlexSole', description: 'always smell like roses',
 price: 200, photo_url: 'http://bikereviews.com/wp-content/uploads/2009/10/cannondale-aerospeed-comp-cycling-shoes.jpg',
 category_ids: [Category.find_by_name('Shoes').id.to_s])
products << Product.create(title: 'Carbonite', description: 'strong carbon fiber sole',
 price: 120, photo_url: 'http://a248.e.akamai.net/origin-cdn.volusion.com/sb4jw.nuvx9/v/vspfiles/photos/7735068250605-2T.jpg',
 category_ids: [Category.find_by_name('Shoes').id.to_s])
#Helmets
products << Product.create(title: 'Streaker', description: 'so comfortable',
 price: 100, photo_url: 'http://moobike.com/wp-content/uploads/2011/02/Specialized-Racing-Bike-Helmet-Prevail-Black.jpg',
 category_ids: [Category.find_by_name('Helmets').id.to_s])
products << Product.create(title: 'Dark Knight', description: 'perfect fit',
 price: 200, photo_url: 'http://www.productwiki.com/upload/images/fox_racing_flux_mountain_bike_helmet.jpg',
 category_ids: [Category.find_by_name('Helmets').id.to_s])
products << Product.create(title: 'XC90', description: 'strong and durable',
 price: 150, photo_url: 'http://media.rei.com/media/tt/32cf3cca-0d8f-4a64-84a2-58664df39b58.jpg',
 category_ids: [Category.find_by_name('Helmets').id.to_s])
products << Product.create(title: 'Rover', description: 'protects your melon',
 price: 199.50, photo_url: 'http://ecx.images-amazon.com/images/I/51y95sPCMaL.jpg',
 category_ids: [Category.find_by_name('Helmets').id.to_s])
products << Product.create(title: 'Thick Head', description: 'looks great',
 price: 75, photo_url: 'http://27.media.tumblr.com/tumblr_lzshngrNdQ1r6d1joo1_500.jpg',
 category_ids: [Category.find_by_name('Helmets').id.to_s])
#Tires
products << Product.create(title: 'BollingerX', description: 'nails stand no chance',
 price: 100, photo_url: 'http://www.rei.com/zoom/ww/a0f87a2a-aeef-4a60-91d9-d30200b811fc.jpg/440',
 category_ids: [Category.find_by_name('Tires').id.to_s])
products << Product.create(title: 'Trek5', description: 'perfect fit',
 price: 50, photo_url: 'http://fatgirl2fitgirl.com/wp-content/uploads/2011/04/change-bike-tire-mountain-road-800X800.jpg',
 category_ids: [Category.find_by_name('Tires').id.to_s, Category.find_by_name('Bikes').id.to_s])
products << Product.create(title: 'Cannondale5', description: 'strong and durable',
 price: 75, photo_url: 'http://media.rei.com/media/211384.jpg',
 category_ids: [Category.find_by_name('Tires').id.to_s, Category.find_by_name('Bikes').id.to_s])
products << Product.create(title: 'AlphaBlue', description: 'smoothes your ride',
 price: 80, photo_url: 'http://luxlow.com/wp-content/uploads/wpsc/product_images/ti27color1.jpg',
 category_ids: [Category.find_by_name('Tires').id.to_s, Category.find_by_name('Bikes').id.to_s])
products << Product.create(title: 'Warrior', description: 'looks great',
 price: 30, photo_url: 'http://www.rei.com/zoom/ee/d4be100d-a394-4a1f-bfd2-964fb5b0b9f7.jpg/440',
 category_ids: [Category.find_by_name('Tires').id.to_s, Category.find_by_name('Bikes').id.to_s])
#Accessories
products << Product.create(title: 'Water Bottle', description: 'stay hydrated in style',
 price: 10, photo_url: 'http://reviews.roadbikereview.com/files/2009/12/camelbak_podium.jpg',
 category_ids: [Category.find_by_name('Accessories').id.to_s])
products << Product.create(title: 'Heart Rate Pro', description: 'none slip and accurate',
 price: 100, photo_url: 'http://runningwatchguide.com/wp-content/uploads/2011/11/Polar-RS300X-Heart-Rate-Monitor2.jpg',
 category_ids: [Category.find_by_name('Accessories').id.to_s])
products << Product.create(title: 'Sunglasses', description: 'blocks all UV light',
 price: 80, photo_url: 'http://www.vpcam.com/members/1402226/uploaded/10882.jpg',
 category_ids: [Category.find_by_name('Accessories').id.to_s])
products << Product.create(title: 'Clipless Pedals', description: 'for racers',
 price: 75, photo_url: 'http://www.tri-1st.co.uk/triathlon/images/products/keocleats.jpg',
 category_ids: [Category.find_by_name('Accessories').id.to_s, Category.find_by_name('Bikes').id.to_s ])
products << Product.create(title: 'Toe Clips', description: 'perfect for commuting',
 price: 30, photo_url: 'http://www.bikegallery.com/blog/wp-content/uploads/2010/08/toeclip.jpg',
 category_ids: [Category.find_by_name('Accessories').id.to_s, Category.find_by_name('Bikes').id.to_s ])

#ORDERS
orders = []
2.times do
  ["pending", "paid", "shipped", "cancelled", "returned"].each do |status|
    orders << Order.create(status: status, user_id: User.all.sample.id)
  end
end

#LineItems

10.times do
  prod = Product.all.sample
  LineItem.create(order_id: orders.sample.id, price: prod.price, product_id: prod.id, quantity: [0..5].sample )
end