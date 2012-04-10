Product.delete_all
chad = User.create(full_name: "Chad Fowler", email: "chad.fowler@livingsocial.com", password: "hungry", user_name: "SaxPlayer", admin: true)
jeff = User.create(full_name: "Jeff", email: "jeff.casimir@livingsocial.com", password: "hungry", user_name: "j3", admin: false)
matt = User.create(full_name: "Matt Yoho", email: "matt.yoho@livingsocial.com", password: "hungry", admin: false)

toys = Category.create(name: "toys")

yoyo = Product.create(title: "yoyo", description: "fun!", price: 2.88, photo: "http://upload.wikimedia.org/wikipedia/commons/thumb/0/07/Us_yoyo_national_1a.jpg/220px-Us_yoyo_national_1a.jpg")



