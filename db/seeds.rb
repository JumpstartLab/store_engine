# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

c1 = Category.create(name: "Meat and Poultry")
c2 = Category.create(name: "Seafood")
c3 = Category.create(name: "Fruit and Vegetable")
c4 = Category.create(name: "Other")
c5 = Category.create(name: "Other Other")

p1 = Product.create(name: "Squid",
                    price_in_cents: 499,
                    description: "It's a whole squid, canned for freshness. Preserved in its natural ink!",
                    photo_url: "http://foodnetworkhumor.com/img/canned-food-17.jpg")

p2 = Product.create(name: "Escargot",
                    price_in_cents: 1450,
                    description: "It's a can full of snails, shells on. Bon apetit!",
                    photo_url: "http://foodnetworkhumor.com/img/canned-food-13.jpg")

p3 = Product.create(name: "Giant Bug Chili Paste",
                    price_in_cents: 199,
                    description: "A dipping paste for tortilla chips, vegetables, etc.",
                    photo_url: "http://foodnetworkhumor.com/img/canned-food-3.jpg")

p4 = Product.create(name: "Roasted Scorpions",
                    price_in_cents: 399,
                    description: "Don't settle for raw canned scorpions; these come pre-roasted and ready to eat!",
                    photo_url: "http://foodnetworkhumor.com/img/canned-food-4.jpg")

p5 = Product.create(name: "Canned Russian Herring",
                    price_in_cents: 49,
                    description: "Caution: may include bones... and teeth.",
                    photo_url: "http://foodnetworkhumor.com/img/canned-food-5.jpg")

p6 = Product.create(name: "Cheeseburger",
                    price_in_cents: 649,
                    description: "You didn't think it could be done, but here it is: a canned cheeseburger, fully ready to eat. We figured out the 'how', you go ahead and figure out the 'why'.",
                    photo_url: "http://foodnetworkhumor.com/img/canned-food-6.jpg")

p7 = Product.create(name: "Armadillo",
                    price_in_cents: 349,
                    description: "Exactly what it says on the label.",
                    photo_url: "http://foodnetworkhumor.com/img/canned-food-7.jpg")

p8 = Product.create(name: "Gourmet Creamed Possum",
                    price_in_cents: 1999,
                    description: "Fine creamed possum, garnished with 'coon fat gravy. You don't get more gourmet hillbilly than this! No, you should not take that as a challenge, please.",
                    photo_url: "http://foodnetworkhumor.com/img/canned-food-9.jpg")

p9 = Product.create(name: "Jellied Eels",
                    price_in_cents: 1279,
                    description: "Traditional jellied eels, not your newfangled digitally jellied eels.",
                    photo_url: "http://foodnetworkhumor.com/img/canned-food-11.jpg")

p10 = Product.create(name: "Frog Legs",
                    price_in_cents: 1479,
                    description: "The spicy basil is holy, so the frog legs taste divine!",
                    photo_url: "http://foodnetworkhumor.com/img/canned-food-2.jpg")

p11 = Product.create(name: "Powdered Eggs",
                    price_in_cents: 299,
                    description: "They're eggs, then we powdered them, what up?!",
                    photo_url: "http://foodnetworkhumor.com/img/canned-food-14.jpg")

p12 = Product.create(name: "Huitlacoche",
                    price_in_cents: 850,
                    description: "This is also known as corn smut, and now you can never unlearn that fact.",
                    photo_url: "http://foodnetworkhumor.com/img/canned-food-16.jpg")

p13 = Product.create(name: "Chicken Luncheon Meat",
                    price_in_cents: 399,
                    description: "It's kind of like Spam, except we made it out of chicken instead of whatever Spam is made of.",
                    photo_url: "http://foodnetworkhumor.com/img/canned-food-1.jpg")

p14 = Product.create(name: "Liverspread",
                    price_in_cents: 599,
                    description: "25% free! The only thing better than liverspread is more liverspread.",
                    photo_url: "http://foodnetworkhumor.com/img/canned-food-18.jpg")

p15 = Product.create(name: "Bacon",
                    price_in_cents: 899,
                    description: "All (or most) of the deliciousness of bacon with all the convenience of a can.",
                    photo_url: "http://foodnetworkhumor.com/img/canned-food-20.jpg")

p16 = Product.create(name: "Whole Chicken",
                    price_in_cents: 949,
                    description: "I... we... we apologize for this.",
                    photo_url: "http://foodnetworkhumor.com/img/canned-food-38.jpg")

p17 = Product.create(name: "Grass Jelly",
                    price_in_cents: 349,
                    description: "Not quite grass, not quite jelly.",
                    photo_url: "http://foodnetworkhumor.com/img/canned-food-35.jpg")

p18 = Product.create(name: "Silkworm Pupae",
                    price_in_cents: 699,
                    description: "Crunchy and juicy at the same time!",
                    photo_url: "http://foodnetworkhumor.com/img/canned-food-33.jpg")

p19 = Product.create(name: "Lard in a BUCKET",
                    price_in_cents: 1779,
                    description: "Put on a pound or seventy for the winter!",
                    photo_url: "http://foodnetworkhumor.com/img/canned-food-24.jpg")

p20 = Product.create!(name: "Rattlesnake",
                    description: "Now with more Dingo Juice!",
                    price_in_cents: 1479,
                    photo_url: "http://foodnetworkhumor.com/img/canned-food-43.jpg")



p1.categorize [c2, c4]
p2.categorize c4
p3.categorize c5
p4.categorize c4
p5.categorize c5
p6.categorize c1
p7.categorize [c1, c4]
p8.categorize [c1, c5]
p9.categorize [c2, c4]
p10.categorize c4
p11.categorize c4
p12.categorize [c3, c5]
p13.categorize c1
p14.categorize c1
p15.categorize c1
p16.categorize c1
p17.categorize c3
p18.categorize c5
p19.categorize c4
p20.categorize c4

u1 = User.create!(full_name: "Mark Tabler", email: "a@b.com", password: "asdfasdf", password_confirmation: "asdfasdf")
u2 = User.create!(full_name: "Charles Strahan", email: "b@c.com", password: "asdfasdf", password_confirmation: "asdfasdf")
u3 = User.create!(full_name: "Happy Admin", email: "admin@store.com", password: "asdfasdf", password_confirmation: "asdfasdf")
u3.update_attribute(:admin, true)
u3.update_attributes(billing_address: "My Billing Address", shipping_address: "My Shipping Address")

u4 = User.create!(full_name: "Matt Yoho", email: "matt.yoho@livingsocial.com", display_name: "", password: "hungry", password_confirmation: "hungry")
u5 = User.create!(full_name: "Jeff Casimir", email: "jeff.casimir@livingsocial.com", display_name: "j3", password: "hungry", password_confirmation: "hungry")
u6 = User.create!(full_name: "Chad Fowler", email: "chad.fowler@livingsocial.com", display_name: "sax_player", password: "hungry", password_confirmation: "hungry")
u6.update_attribute(:admin, true)

u7 = User.create!(full_name: "Matt Yoho", email: "demo04+matt@jumpstartlab.com", display_name: "", password: "hungry", password_confirmation: "hungry")
u8 = User.create!(full_name: "Jeff Casimir", email: "demo04+jeff@jumpstartlab.com", display_name: "j3", password: "hungry", password_confirmation: "hungry")
u9 = User.create!(full_name: "Chad Fowler", email: "demo04+chad@jumpstartlab.com", display_name: "sax_player", password: "hungry", password_confirmation: "hungry")
u9.update_attribute(:admin, true)


o = []
100.times do |i|
o[i] = Order.create!(billing_address: "#{(rand * 10000).to_i} any street", 
                   shipping_address: "Home Sweet Home",
                   email_address: "Fakey Email #{i}",
                   status: 'pending',
                   credit_card: "Bogus Card # #{i}")
     5.times do 
          o[i].order_items.create!(product_id: (rand * 20).to_i + 1,
                                  quantity: (rand * 10).to_i + 1)
     end
     o[i].update_attribute(:status, Order::STATUSES.sample)
     o[i].update_attribute(:status_date, (rand * 30).to_i.days.ago)
end
