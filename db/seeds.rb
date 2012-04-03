# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
matt = User.create(:first_name => "Matt", :last_name => "Yoho",
      :email => "matt.yoho@livingsocial.com", :password => "hungry", :admin = true )

jeff = User.create(:first_name => "Jeff", :last_name => "",
      :email => "jeff.casimir@livingsocial.com", :password => "hungry", :display_name => "j3")

chad = User.create(:first_name => "Chad", :last_name => "Fowler",
      :email => "chad.fowler@livingsocial.com", :password => "hungry", :display_name => "SaxPlayer")