User.create(:username => "Matt Yoho", :email => "matt.yoho@livingsocial.com",
            :password => "hungry")
User.create( :username => "Jeff", :email => "jeff.casimir@livingsocial.com",
            :password => "hungry")
User.create( :username => "Chad Fowler", 
            :email => "chad.fowler@livingsocial.com", :password => "hungry")
Category.create(:name => "awesome")
Category.create(:name => "not as awesome")
Category.create(:name => "pretty terrible")

["pending", "cancelled", "paid", "shipped", "returned"].each do |s|
  Status.create(:name => s)
end