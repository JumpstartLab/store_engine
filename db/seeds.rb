# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create(:username => "Matt Yoho", :email => "matt.yoho@livingsocial.com",
            :password => "hungry")
User.create( :username => "Jeff", :email => "jeff.casimir@livingsocial.com",
            :password => "hungry")
User.create( :username => "Chad Fowler", 
            :email => "chad.fowler@livingsocial.com", :password => "hungry")
