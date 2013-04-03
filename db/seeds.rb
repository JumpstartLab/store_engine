User.create(full_name: "Franklin Webber", email: "demoXX+franklin@jumpstartlab.com", password: "password")
User.create(full_name: "Jeff", email: "demoXX+jeff@jumpstartlab.com", password: "password", display_name: "j3")
User.create(full_name: "Steve Klabnik", email: "demoXX+steve@jumpstartlab.com", password: "password", display_name: "SkrilleX", admin: true)



file = File.open('./public/images/great-slump.jpg')
product1 = Product.create(title: "The Great Slump", description: "The Great Slump has a single claw arm.", price: 104.19, status: 'active', image: file)
file.close
file = File.open('./public/images/marcy_shadow.png')
product2 = Product.create(title: "Marcy", description: "Marcy is the most beautiful hairball you'll ever meet.", price: 17.95, status: 'active', image: file)
file.close
file = File.open('./public/images/slump-sr.jpg')
product3 = Product.create(title: "Slump Sr.", description: "Slump Sr. has been there, done that.", price: 2.50, status: 'active', image: file)
file.close
file = File.open('./public/images/slumpy.jpg')
product4 = Product.create(title: "Slumpy", description: "Slumpy enjoys teething.", price: 23.90, status: 'active', image: file)
file.close
file = File.open('./public/images/viking.jpg')
product5 = Product.create(title: "Viking Lord", description: "Viking Lord takes no prisoners.", price: 272.30, status: 'active', image: file)
file.close
file = File.open('./public/images/wizard.jpg')
product6 = Product.create(title: "Wizard", description: "Wizard runs the show in these parts.", price: 1235.99, status: 'active', image: file)
file.close
product7 = Product.create(title: "Coming Soon", description: "Details are on the way.", price: 1.00, status: 'active')
product8 = Product.create(title: "Coming Soon2", description: "etails are on the way.", price: 1.00, status: 'retired')
product9 = Product.create(title: "Coming Soon3", description: "etails are on the way.", price: 1.00, status: 'retired')
product10 = Product.create(title: "Coming Soon4", description: "etails are on the way.", price: 1.00, status: 'active')

Category.create(title: "Hairballs", product_ids: [1, 2, 3, 4])
Category.create(title: "Mystics")
Category.create(title: "Brutes", product_ids: [5, 6])
Category.create(title: "Slimes")
Category.create(title: "Orphans")

order1 = Order.create(status: 'pending', user_id: 1)
order2 = Order.create(status: 'pending', user_id: 1)
order3 = Order.create(status: 'pending', user_id: 1)
order4 = Order.create(status: 'pending', user_id: 2)
order5 = Order.create(status: 'pending', user_id: 2)

order1.order_items.create(product_id: product1.id,
                          unit_price: product1.price,
                          selling_price: product1.current_price,
                          percent_off: product1.percent_off,
                          quantity: 2)

order1.order_items.create(product_id: product2.id,
                          unit_price: product2.price,
                          selling_price: product2.current_price,
                          percent_off: product2.percent_off,
                          quantity: 1)
