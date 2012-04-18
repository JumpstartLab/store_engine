matt = User.create(:username => "Matt Yoho", :first_name => "Matt", :last_name => "Yoho",
            :email => "matt.yoho@livingsocial.com", :password => "hungry", 
            :display_name => "The YOHO")
jeff = User.create( :username => "Jeff", :first_name => "Jeff", :last_name => "Casimir",
            :email => "jeff.casimir@livingsocial.com",
            :password => "hungry")
chad = User.create( :username => "Chad Fowler", :first_name => "Chad",
             :last_name => "Fowler", :email => "chad.fowler@livingsocial.com", 
             :password => "hungry")
chad.admin = true
chad.save!

Category.create(:name => "cute pugs")
Category.create(:name => "awesome pugs")
Category.create(:name => "sweet pugs")
Category.create(:name => "sad face pugs")
Product.create(:title => "Bailey", :description => "Bailey is super cute!", :price => rand(10000).to_s,
               :photo => "http://28.media.tumblr.com/tumblr_lirvqoFIAO1qaa50yo1_500.jpg")
Product.create(:title => "Zeek", :description => "Zeek is the best pug you'll ever meet!",
               :price => rand(10000).to_s, :photo => "http://24.media.tumblr.com/tumblr_lima5j6wR11qzqe35o1_500.jpg")
Product.create(:title => "Lucy", :description => "Lucy is goosey!", :price => rand(10000).to_s,
               :photo => "http://30.media.tumblr.com/tumblr_lj50gs8rAX1qaa50yo1_500.jpg")
# 30.times { Fabricate(:product).save } 
# 
# pending = Status.create(:name => StoreEngine::Status::PENDING)
# Status.create(:name => StoreEngine::Status::CANCELLED)
# paid = Status.create(:name => StoreEngine::Status::PAID)
# shipped = Status.create(:name => StoreEngine::Status::SHIPPED)
# Status.create(:name => StoreEngine::Status::RETURNED)
# 
# shipping_address = Fabricate(:shipping_address)
# shipping_address.save
# billing_address = Fabricate(:billing_address)
# billing_address.save
# 
# item = OrderItem.new(:product => Product.find(1))
# item2 = OrderItem.new(:product => Product.find(3))
# items = [item, item2]
# Order.create(:user => matt, :status => pending, :order_items => items,
#                     :shipping_address => shipping_address, 
#                     :billing_address => billing_address)
# Order.create(:user => jeff, :status => shipped,
#                     :shipping_address => shipping_address, 
#                     :billing_address => billing_address).save
# Order.create(:user => jeff, :status => paid,
#                     :shipping_address => shipping_address, 
#                     :billing_address => billing_address).save
