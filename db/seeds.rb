Category.create(:name => "cute pugs")
Category.create(:name => "awesome pugs")
Category.create(:name => "sweet pugs")
Category.create(:name => "sad face pugs")
Category.create(:name => "sexy pugs")

def create_product(title, description, photo)
  product = Product.create(:title => title, :description => description, 
                 :price => rand(10000).to_s, :photo => photo)
  ids = Category.all.sample(rand(4)).collect do |category| 
    category.id
  end
  product.set_categories(ids)
end

matt = User.create(:first_name => "Matt", :last_name => "Yoho",
            :email => "demoXX+matt@jumpstartlab.com", :password => "hungry", 
            :display_name => "The YOHO")
jeff = User.create(:first_name => "Jeff", :last_name => "Casimir",
            :email => "demoXX+jeff@jumpstartlab.com",
            :password => "hungry")
chad = User.create(:first_name => "Chad",
             :last_name => "Fowler", :email => "demoXX+chad@jumpstartlab.com", 
             :password => "hungry")
chad.admin = true
chad.save!

create_product("Bailey", "Bailey is super cute!", 
               "http://28.media.tumblr.com/tumblr_lirvqoFIAO1qaa50yo1_500.jpg")
create_product("Zeek", "Zeek is the best pug you'll ever meet!",
               "http://24.media.tumblr.com/tumblr_lima5j6wR11qzqe35o1_500.jpg")
create_product("Lucy", "Lucy is goosey!", 
               "http://30.media.tumblr.com/tumblr_lj50gs8rAX1qaa50yo1_500.jpg")
create_product("Sadie", "Sadie is such a sweet, tasty pug.", 
               "http://28.media.tumblr.com/tumblr_locinzasB91qzj3syo1_500.jpg")
create_product("Ginger", "Ginger looooooves cookies!", 
               "http://28.media.tumblr.com/tumblr_locinzasB91qzj3syo1_500.jpg")
create_product("Charlie", "It's highly advisable to not bite his finger", 
               "http://27.media.tumblr.com/tumblr_llq0m1ofS71qk2cjro1_500.jpg")
create_product("Bear", "He'll maul you with love!", 
               "http://30.media.tumblr.com/tumblr_lisw5dD4Pu1qbbpjfo1_400.jpg")
create_product("Inky", "The beach. The sun. Inky doesn't discriminate", 
               "http://26.media.tumblr.com/tumblr_lirnni3XjG1qzgcv7o1_500.png")
create_product("Annie", "Pugs pugs pugs pugs pugs pugs pugs pugs pugs", 
               "http://27.media.tumblr.com/tumblr_ltuo57ahqE1qa6z3eo1_500.jpg")
create_product("Gizmo", "Gizmo duck...pug!", 
               "http://27.media.tumblr.com/tumblr_ll3xua50Vr1qb08qmo1_500.jpg")
create_product("Isabella", "Bella mia!", 
               "http://29.media.tumblr.com/tumblr_lhjuu5y74J1qaa50yo1_500.jpg")
create_product("Oscar", "He's a cute pug, but he's so grouchy!", 
               "http://29.media.tumblr.com/tumblr_ll267csxAQ1qb08qmo1_500.jpg")
create_product("Rex", "RAWR! Means I love you in pug.", 
               "http://24.media.tumblr.com/tumblr_lk7u170Ztt1qb33vho1_500.jpg")
create_product("Rose", "Smells so sweet. Then she bites you. Hard.", 
               "http://27.media.tumblr.com/tumblr_lhty7gGku61qb08qmo1_500.jpg")
create_product("Scooter", "Scoot Scoot Scoot. He's not potty trained yet.", 
               "http://27.media.tumblr.com/tumblr_lhtxzoe4lb1qb08qmo1_500.jpg")
create_product("Socks", "Hide your socks! No socks are safe from this pug!", 
               "http://27.media.tumblr.com/tumblr_lojtswfhv41qzio3qo1_500.jpg")
create_product("Max", "Favorite movie? Mad Max and the Thunderdome.", 
               "http://24.media.tumblr.com/tumblr_lixgdemCvf1qaa50yo1_500.jpg")
create_product("Spike", "Insert witty pug comment here.", 
               "http://24.media.tumblr.com/tumblr_li5lkvn1xF1qaa50yo1_500.jpg")
create_product("Magic", "Just like the rails.", 
               "http://28.media.tumblr.com/tumblr_lim8n49s881qa9dmvo1_500.jpg")
create_product("Katie", "Why do people name their cute pugs after humans?", 
               "http://29.media.tumblr.com/tumblr_lixd8gn85W1qa1nfco1_500.jpg")

pending = Status.create(:name => StoreEngine::Status::PENDING)
paid = Status.create(:name => StoreEngine::Status::PAID)
returned = Status.create(:name => StoreEngine::Status::RETURNED)
shipped = Status.create(:name => StoreEngine::Status::SHIPPED)
cancelled = Status.create(:name => StoreEngine::Status::CANCELLED)

 address = {:first_name => "Melanie", :last_name => "Gilman", 
            :company => "LivingSocial", :line_1 => "New York Ave", 
            :city => "Washington", :state => "DC", :zipcode => "20005", 
            :phone => "555-555-5555"}
 shipping_address = ShippingAddress.create(address)
 billing_address = BillingAddress.create(address)
 
 def create_order(user, status, shipping_address, billing_address)
   order = Order.create(:user => user, :status => status, 
                :shipping_address => shipping_address, 
                :billing_address => billing_address)

   products = Product.all
   product_count = rand(10)
   product_count.times do |i|
     product= products[i] 
     item = OrderItem.new(:product => product, :quantity => rand(30), 
                          :price => product.price.to_s)
     item.order = order
     item.save
   end
 end

 create_order(matt, pending, shipping_address, billing_address)
 create_order(jeff, pending, shipping_address, billing_address)
 create_order(matt, paid, shipping_address, billing_address)
 create_order(jeff, paid, shipping_address, billing_address)
 create_order(matt, returned, shipping_address, billing_address)
 create_order(jeff, returned, shipping_address, billing_address)
 create_order(matt, shipped, shipping_address, billing_address)
 create_order(jeff, shipped, shipping_address, billing_address)
 create_order(matt, cancelled, shipping_address, billing_address)
 create_order(jeff, cancelled, shipping_address, billing_address)
