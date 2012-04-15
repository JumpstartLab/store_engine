Product.delete_all
CategoryAssignment.delete_all
Category.delete_all

chad = User.create(full_name: "Chad Fowler", email: "chad.fowler@livingsocial.com", password: "hungry", user_name: "SaxPlayer", admin: true)
jeff = User.create(full_name: "Jeff", email: "jeff.casimir@livingsocial.com", password: "hungry", user_name: "j3", admin: false)
matt = User.create(full_name: "Matt Yoho", email: "matt.yoho@livingsocial.com", password: "hungry", admin: false)

baby_products = Category.create(name: "Baby Products")
snacks = Category.create(name: "Snacks")
gifts = Category.create(name: "Gifts")

baby_wash = Product.create(title: "Aquaphor Baby Gentle Wash", 
                           description: "2 in 1 formula. With soothing chamomile and provitamin B5 for healthy skin and hair. Gently cleanses with no tears. Pediatrician recommended. Your baby's delicate skin and hair can become dry and easily irritated from soaps or even water. That is because a baby's skin is thinner and more sensitive than adult skin. The solution? Aquaphor Gentle Wash and Shampoo, a mild 2 in 1 wash that gently cleanses skin and hair without drying. Enriched with soothing chamomile essence and provitamin B5, it is specially designed and clinically proven to be gentle for baby's sensitive skin. Tear-free. Free of fragrances and dyes. Cleanses with a light lather that rinses easily. Washes hair without irritating scalp. Pediatrician recommended brand.", 
                           price: 7.59, 
                           photo: "http://static-resources.goodguide.net/images/entities/large/355628-2.jpg")
CategoryAssignment.create(product: baby_wash, category: baby_products)

chocolate_bar = Product.create(title: "Green and Blacks Dark 85% Chocolate Bar",
                               description: "Even the most casual food shoppers have probably noticed the increased quantity and variety of organic products available and they vary from food to detergent, cosmetics and many more.",
                               price: 4.00,
                               photo: "http://media.treehugger.com/assets/images/2011/10/chocolate-green.jpg")
CategoryAssignment.create(product: chocolate_bar, category: snacks)
CategoryAssignment.create(product: chocolate_bar, category: gifts)



