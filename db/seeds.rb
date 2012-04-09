Product.delete_all
chad = User.create(full_name: "Chad Fowler", email: "chad.fowler@livingsocial.com", password: "hungry", user_name: "SaxPlayer", admin: true)
matt_order = Order.create(user_id: 1)
toys = Category.create(name: "toys")
yoyo = Product.create(title: "yoyo", description: "fun!", price: 2.88, category_id: 1, photo: "http://upload.wikimedia.org/wikipedia/commons/thumb/0/07/Us_yoyo_national_1a.jpg/220px-Us_yoyo_national_1a.jpg")
matt_order.order_items.create(product_id: yoyo.id, price: yoyo.price, quantity: 2)
