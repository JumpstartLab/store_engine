# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
matt = User.create(:first_name => "Matt", :last_name => "Yoho",
      :email => "matt.yoho@livingsocial.com", :password => "hungry" )

jeff = User.create(:first_name => "Jeff", :last_name => "",
      :email => "jeff.casimir@livingsocial.com", :password => "hungry", :display_name => "j3")

chad = User.create(:first_name => "Chad", :last_name => "Fowler",
      :email => "chad.fowler@livingsocial.com", :password => "hungry", :display_name => "SaxPlayer", :admin => true)


chair = Product.create(:title => "Sweet chair", :description => "This is a great chair", :price => "5.00", :remote_image_url => "http://ecx.images-amazon.com/images/I/31pVwh3qNvL._SL500_AA300_.jpg")

table = Product.create(:title => "Great table", :description => "This is the sweetest table", :price => "10.00", :remote_image_url => "http://ecx.images-amazon.com/images/I/31lRJMSUDOL._SL500_AA300_.jpg")

desk = Product.create(:title => "Amazing desk", :description => "This is the coolest desk", :price => "20.00", :remote_image_url => "http://www.vintagedanishmodern.com/products/87381.jpg")