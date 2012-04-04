# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
s1 = Status.create(:name => "Shipped")
s2 = Status.create(:name => "Pending")
s3 = Status.create(:name => "Failed")
s4 = Status.create(:name => "Successful")

u1 = User.create(
           :name => "Mike Silvis", 
           :password => "mike", 
           :email => "mikesilvis@gmail.com",
           :display_name => "mike"
          )
u1.permission = 9
u1.save
u2 = User.create(
           :name => "Nisarg Shah", 
           :password => "nisarg", 
           :email => "nisargshah100@gmail.com",
           :display_name => "nisarg"
          )
u2.permission = 9
u2.save
User.create(
           :name => "Matt Yoho", 
           :password => "hungry", 
           :email => "matt.yoho@livingsocial.com",
           :display_name => ""
          )
User.create(
           :name => "Jeff", 
           :password => "hungry", 
           :email => "jeff.casimir@livingsocial.com",
           :display_name => "j3"
          )
User.create(
           :name => "Chad Fowler", 
           :password => "hungry", 
           :email => "chad.fowler@livingsocial.com",
           :display_name => "SaxPlayer"
          )
c1 = Category.create( :name => "Fruit"  )
c2 = Category.create( :name => "Toys"   )
c3 = Category.create( :name => "Wheels" ) 
p1 = Product.create(
                    :name => "Apple", 
                    :description => "Yummy wormy apple", 
                    :price => "1.00",
                   )
p2 = Product.create(
                    :name => "Bananas", 
                    :description => "Why do gorillas always eat me?", 
                    :price => "2.75",
                    :categories => [c1]
                   )
p3 = Product.create(
                    :name => "Racecar", 
                    :description => "VRRRRRRRRRMMMMMMM", 
                    :price => "20.65",
                    :categories => [c3,c2]
                   )
o1 = Order.create(
                   :user => u1,
                   :status => s1,
                   :products => [p1, p2]
                  )
o2 = Order.create(
                   :user => u1,
                   :status => s2,
                   :products => [p1, p3]
                  )


