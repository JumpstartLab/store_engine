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

Category.create(:name => "awesome")
Category.create(:name => "not as awesome")
Category.create(:name => "pretty terrible")

30.times { Fabricate(:product).save } 

pending = Status.create(:name => StoreEngine::Status::PENDING)
Status.create(:name => StoreEngine::Status::CANCELLED)
paid = Status.create(:name => StoreEngine::Status::PAID)
shipped = Status.create(:name => StoreEngine::Status::SHIPPED)
Status.create(:name => StoreEngine::Status::RETURNED)

shipping_address = Fabricate(:shipping_address)
shipping_address.save
billing_address = Fabricate(:billing_address)
billing_address.save

item = Fabricate(:order_item) 
item2 = Fabricate(:order_item) 
items = [Fabricate(:order_item),Fabricate(:order_item)]
Order.create(:user => matt, :status => pending, 
             :order_items => [Fabricate(:order_item),Fabricate(:order_item)],
                    :shipping_address => shipping_address, 
                    :billing_address => billing_address)
Order.create(:user => jeff, :status => shipped,
             :order_items => [Fabricate(:order_item),Fabricate(:order_item)],
                    :shipping_address => shipping_address, 
                    :billing_address => billing_address).save
Order.create(:user => jeff, :status => paid,
             :order_items => [Fabricate(:order_item),Fabricate(:order_item)],
                    :shipping_address => shipping_address, 
                    :billing_address => billing_address).save
