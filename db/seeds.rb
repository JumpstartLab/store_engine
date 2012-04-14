User.create(:username => "Matt Yoho", :first_name => "Matt", :last_name => "Yoho",
            :email => "matt.yoho@livingsocial.com", :password => "hungry")
User.create( :username => "Jeff", :first_name => "Jeff", :last_name => "Casimir",
            :email => "jeff.casimir@livingsocial.com",
            :password => "hungry")
User.create( :username => "Chad Fowler", :admin => true, :first_name => "Chad",
             :last_name => "Fowler", :email => "chad.fowler@livingsocial.com", 
             :password => "hungry")
User.create( :username => "admin", :admin => true, :first_name => "admin", 
             :last_name => "admin", :email => "admin@livingsocial.com", 
             :password => "admin")

Category.create(:name => "awesome")
Category.create(:name => "not as awesome")
Category.create(:name => "pretty terrible")

30.times { Fabricate(:product).save } 

["pending", "cancelled", "paid", "shipped", "returned"].each do |s|
  Status.create(:name => s)
end
