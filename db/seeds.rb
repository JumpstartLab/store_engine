# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin = User.create!(name: "Example User",
                         email: "exampleuser@example.com",
                         display_name: "Foobarrington",
                         password: "foobar",
                         password_confirmation: "foobar")
    admin.toggle!(:admin)

    chad = User.create!(name: "Chad Fowler",
                        email: "demoXX+chad@jumpstartlab.com",
                        display_name: "SaxPlayer",
                        password: "hungry",
                        password_confirmation: "hungry")
    chad.toggle!(:admin)

    matt = User.create!(name: "Matt Yoho",
                        email: "demoXX+matt@jumpstartlab.com",
                        password: "hungry",
                        password_confirmation: "hungry")

    jeff = User.create!(name: "Jeff",
                        email: "demoXX+jeff@jumpstartlab.com",
                        display_name: "j3",
                        password: "hungry",
                        password_confirmation: "hungry")

    @starter_category_count = 10
    @starter_category_count.times do |n|
      name = ["Category", n].join(' ')
      Category.create!(name: name)
    end


    product_one = Product.new
    product_one.title = "The First Product"
    product_one.description = "Lorem ipsum dolor sit amet."
    product_one.price = rand(10000) + 1
    product_one.photo = "http://placehold.it/260x180"
    product_one.category_ids = [1, 2, 5]
    product_one.retired = false
    product_one.save

    product_two = Product.new
    product_two.title = "The Second Product"
    product_two.description = "Lorem ipsum dolor sit amet."
    product_two.price = rand(10000) + 1
    product_two.photo = "http://placehold.it/260x180"
    product_two.category_ids = [3, 5, 8]
    product_two.retired = false
    product_two.save

    product_three = Product.new
    product_three.title = "The Third Product"
    product_three.description = "Lorem ipsum dolor sit amet."
    product_three.price = rand(10000) + 1
    product_three.photo = "http://placehold.it/260x180"
    product_three.category_ids = [2, 6, 4]
    product_three.retired = false
    product_three.save

    25.times do |n|
      title = ["Product Name", n ].join(' ')
      description = "Lorem ipsum dolor sit amet."
      price = rand(10000) + 1 
      photo = "http://placehold.it/260x180"
      category_ids = [1]
      rand(6).times do |n|
        category_ids << rand(@starter_category_count) + 1
      end
      retired = false 
      Product.create!(title: title,
                      description: description,
                      price: price,
                      photo: photo,
                      category_ids: category_ids,
                      retired: retired)
    end