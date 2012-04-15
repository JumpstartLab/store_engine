User.create(:username => "Matt Yoho", :first_name => "Matt", :last_name => "Yoho",
            :email => "matt.yoho@livingsocial.com", :password => "hungry")
User.create( :username => "Jeff", :first_name => "Jeff", :last_name => "Casimir",
            :email => "jeff.casimir@livingsocial.com",
            :password => "hungry")
User.create( :username => "Chad Fowler", :admin => true, :first_name => "Chad",
             :last_name => "Fowler", :email => "chad.fowler@livingsocial.com", 
             :password => "hungry")

Category.create(:name => "awesome")
Category.create(:name => "not as awesome")
Category.create(:name => "pretty terrible")

30.times { Fabricate(:product).save } 

Status.create(:name => StoreEngine::Status::PENDING)
Status.create(:name => StoreEngine::Status::CANCELLED)
Status.create(:name => StoreEngine::Status::PAID)
Status.create(:name => StoreEngine::Status::SHIPPED)
Status.create(:name => StoreEngine::Status::RETURNED)
