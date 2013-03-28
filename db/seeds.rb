User.create(full_name: "Franklin Webber", email: "demoXX+franklin@jumpstartlab.com", password: "password")
User.create(full_name: "Jeff", email: "demoXX+jeff@jumpstartlab.com", password: "password", display_name: "j3")
User.create(full_name: "Steve Klabnik", email: "demoXX+steve@jumpstartlab.com", password: "password", display_name: "SkrilleX", admin: true)

Category.create(title: "Close Shave")
Category.create(title: "Bangs")
Category.create(title: "Goatees")
Category.create(title: "Pony Tails")
Category.create(title: "Mullets")

product1 = Product.create(title: "teef", description: "horse teef", price: 0.19, status: 'active')
product2 = Product.create(title: "teefies", description: "horse teef", price: 0.19, status: 'active')
product3 = Product.create(title: "tee", description: "horse teef", price: 0.19, status: 'active')
product4 = Product.create(title: "te", description: "horse teef", price: 0.19, status: 'active')
product5 = Product.create(title: "t", description: "horse teef", price: 0.19, status: 'active')
product6 = Product.create(title: "tasaf", description: "horse teef", price: 0.19, status: 'active')
product7 = Product.create(title: "tasafadasf", description: "horse teef", price: 0.19, status: 'active')
product8 = Product.create(title: "tasafadasfasd", description: "horse teef", price: 0.19, status: 'active')
product9 = Product.create(title: "tasafad", description: "horse teef", price: 0.19, status: 'active')
product10 = Product.create(title: "tasaf", description: "horse teef", price: 0.19, status: 'active')

order1 = Order.create(status: 'pending', user_id: 1)
order2 = Order.create(status: 'pending', user_id: 1)
order3 = Order.create(status: 'pending', user_id: 1)
order4 = Order.create(status: 'pending', user_id: 2)
order5 = Order.create(status: 'pending', user_id: 2)

order1.order_items.create(product_id: product1.id,
                          unit_price: product1.price,
                          quantity: 2)

order1.order_items.create(product_id: product2.id,
                          unit_price: product2.price,
                          quantity: 1)
