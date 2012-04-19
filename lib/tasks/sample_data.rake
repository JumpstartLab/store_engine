namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
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
    99.times do |n|
      name  = Faker::Name.name
      display_name  = Faker::Name.name
      email = "example-#{n+1}@example.org"
      password  = "password"
      User.create!(name: name,
                   display_name: display_name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
    99.times do |n|
      title = Faker::Lorem.words(1).first
      description = Faker::Lorem.paragraph
      price = rand(10000) + 1 
      photo = "http://portfolio.adigitalnative.com/style/images/th7.jpg"
      category_ids = nil 
      retired = false 
      Product.create!(title: title,
                      description: description,
                      price: price,
                      photo: photo,
                      category_ids: category_ids,
                      retired: retired)
    end
  end
end