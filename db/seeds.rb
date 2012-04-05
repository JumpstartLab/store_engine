# matt = User.create(full_name: "Matt Yoho", email: "matt.yoho@livingsocial.com", password: "hungry")
matt_order = Order.create(user_id: 1)
yoyo = Product.create(title: "yoyo", description: "fun!", price: 2.88)
matt_order.order_items.create(product_id: yoyo.id, price: yoyo.price, quantity: 2)
