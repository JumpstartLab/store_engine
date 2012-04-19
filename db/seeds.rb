Product.delete_all
CategoryAssignment.delete_all
Category.delete_all

chad = User.create(full_name: "Chad Fowler", email: "demo09+chad@jumpstartlab.com", password: "hungry", user_name: "SaxPlayer")
jeff = User.create(full_name: "Jeff", email: "demo09+jeff@jumpstartlab.com", password: "hungry", user_name: "j3")
matt = User.create(full_name: "Matt Yoho", email: "demo09+matt@jumpstartlab.com", password: "hungry")

chad.update_attribute(:admin, true)

baby_products = Category.create(name: "Baby Products")
snacks = Category.create(name: "Food and Snacks")
gifts = Category.create(name: "Gifts")
home = Category.create(name: "Household Products")
beauty = Category.create(name: "Beauty Products")

aqua = Product.create(title: "Aquaphor Baby Gentle Wash", 
                           description: "2 in 1 formula. With soothing chamomile and provitamin B5 for healthy skin and hair. Gently cleanses with no tears. Pediatrician recommended. Your baby's delicate skin and hair can become dry and easily irritated from soaps or even water. That is because a baby's skin is thinner and more sensitive than adult skin. The solution? Aquaphor Gentle Wash and Shampoo, a mild 2 in 1 wash that gently cleanses skin and hair without drying. Enriched with soothing chamomile essence and provitamin B5, it is specially designed and clinically proven to be gentle for baby's sensitive skin. Tear-free. Free of fragrances and dyes. Cleanses with a light lather that rinses easily. Washes hair without irritating scalp. Pediatrician recommended brand.", 
                           price: 7.59, 
                           photo: "http://static-resources.goodguide.net/images/entities/large/355628-2.jpg",
                           upc: "072140002282")

chocolate = Product.create(title: "Green and Blacks Dark 85% Chocolate Bar",
                               description: "Even the most casual food shoppers have probably noticed the increased quantity and variety of organic products available and they vary from food to detergent, cosmetics and many more.",
                               price: 4.00,
                               photo: "http://media.treehugger.com/assets/images/2011/10/chocolate-green.jpg",
                               upc: "708656100005")

now = Product.create(title: "Now Foods XYLITOL",
                    description: "Natural and Fluoride-Free With Xylitol Steam-Distilled Essential Oils Freshens Breath Cleanses Mouth Promotes Dental Health NOW Cinnafresh Mouthwash is an effective fluoride-free oral rinse that works in unique ways to help you achieve a smile that's healthier and brighter than ever before! Cinnafresh Mouthwash gets its cleansing properties from xylitol - a naturally occurring sugar alcohol that has been shown in clinical studies to help promote dental health effectively rinsing debris, such as, food particles containing bacteria from mouth surfaces. Xylitol also helps safeguard healthy tooth enamel surfaces",
                    price: 5.49,
                    photo: "http://ecx.images-amazon.com/images/I/21QLiGcMLTL._AA300_PIbundle-1,TopRight,0,0AA300_SH20_.jpg",
                    upc: "733739080967")

toms = Product.create(title: "Tom's of Maine Cleansing Mouthwash-Spearmint-16, oz",
                      description: "Our alcohol and saccharin-free natural mouthwash with Vitamin C uses aloe vera to soothe, witch hazel as an astringent, and pure essential oils for refreshing flavor",
                      price: 4.56,
                      photo: "http://ecx.images-amazon.com/images/I/31gJpeNP%2BTL._SL500_AA300_.jpg",
                      upc: "077326401163")

method_wash = Product.create(title: "method Hand Wash", 
                            description: "Washes your hands!",
                            price: 10.99,
                            photo: "http://static-resources.goodguide.net/images/entities/large/188239.jpg",
                            upc: "817939000311")

earth_mate = Product.create(title: "Earth Friendly Products, Dishmate, Pear",
                            description: "DISHMATE,PEAR Quantity: 6 Size: 25 OZ Brand: EARTHF",
                            price: 8.72,
                            photo: "http://ecx.images-amazon.com/images/I/21E7TgdUH%2BL._SL500_AA300_.jpg",
                            upc: "749174097200")

colgate = Product.create(title: "Colgate Wisp Whitening Mini-Brush with Freshening Bead",
                         description: "Colgate WISP disposable mini-brush with freshening beads gives you that just brushed clean. Anytime. Anywhere.",
                         price: 3.99,
                         photo: "http://ecx.images-amazon.com/images/I/412H%2BT1U2HL._AA300_.jpg",
                         upc: "035000689122")

crust = Product.create(title: "Simply Organic Pizza Crust (6x10 OZ)",
                      description: "Simply Organic Pizza Crust (6x10 OZ)",
                      price: 4.90,
                      photo: "http://lh3.googleusercontent.com/public/9K-WGd960fNGEvLiUlgVTOP3wSo6o72npusAlq-HNF-9r4FxrBkZcqzKvCul5JpkScwxDnlOsr9rYFYppbTzXfE-FNwziZPPE81RJPCNTfsPb4YThGzWcUE5RgGCXAFea8SE4QA7FI0HAA",
                      upc: "089836189462")

quaker = Product.create(title: "Quaker Oatmeal Squares, Crunchy Oatmeal Baked in Cinnamon",
                        description: "Made with hearty 100% whole grain Quaker Oats",
                        price: 3.99,
                        photo: "http://t3.gstatic.com/images?q=tbn:ANd9GcRXDlh6F5EKqjCRk4dOl0WOWFyijwW9LxVdWnwjbX2duM-uG_i_GIdiVtnNkg",
                        upc: "030000061503")

california = Product.create(title: "California Baby Bubble Bath: Party",
                            description: "Promotes calmness and ensures a good night's sleep. Non-stripping of delicate mucous membranes, which can lead to yeast or bladder infections",
                            price: 7.98,
                            photo: "http://skepticalmothering.files.wordpress.com/2012/01/california-baby-i-love-you-bubblebath.jpg",
                            upc: "792692004007")

earth_baby = Product.create(title: "Earth Baby Organic Playful Sudzz Baby Bath Gel",
                            description: "Baby Body Wash Gel is natural fragrant, foamy fun! Our creamy, organic foaming bath gel is a gentle and comforting way to cleanse and moisturize baby's skin and scalp. Our pH-balanced wash gel has a deliciously fragrant blend of chamomile, vanilla, and kiwi to make hair as aromatic as it is silky smooth to the touch. Manufactured in the U.S.A.",
                            price: 3.99,
                            photo: "http://ecx.images-amazon.com/images/I/21a-1p98-pL._SL500_AA300_.jpg",
                            upc: "897345001003")

bronner = Product.create(title: "Dr. Bronner's Magic Organic Shaving Soap Gel Baby Unscented", description: "Certified by the same National Organic Program that certifies food our shaving gels are smooth and effective without any synthetic ingredients. Organic Shikakai comes from the seed pods of the small South Asian tree Acacia Concinna. Extracted in organic sucrose and grape juice it provides soothing moisturizing glide. Dr. Bronner's Pure-Castile Baby Mild Soap provides superior hair lift and wetting. Sold in a 7 oz. tube.",
                         price: 4.99,
                         photo: "http://ecx.images-amazon.com/images/I/315tVX6F%2BmL._SL500_AA300_.jpg",
                         upc: "018787940044")

aubrey = Product.create(title: "Aubrey Organics: Women Shaving Parent",
                        description: "Orange Cream 4oz Get Closer. Made with rich emollients and fruit extracts, this moisturizing shave cream pampers and protects your skin for a luxurious, ultra-smooth shave and legs so soft, you may not need a lotion after shaving. You will love its silky feel and heavenly mandarin scent",
                        price: 3.90,
                        photo: "http://ecx.images-amazon.com/images/I/41zDf0mKZrL._AA300_.jpg",
                        upc: "749985420204")

foam = Product.create(title: "EO Shave Foam Unscented, With Coconut Milk, 5-Ounce Bottles",
                      description: "Light & frothy, our Aeorosol Free Shave Foam lubricates skin and provides a clean and smooth shave.",
                      price: 5.43,
                      photo: "http://ecx.images-amazon.com/images/I/315w06-GfJL._SL500_AA300_.jpg",
                      upc: "636874190006")
johnson = Product.create(title: "Johnson's Baby Hand and Face Wipes, 25-count",
                        description: "Johnsons Hand & Face Wipes were designed to gently and effectively remove dirt and germs from babys hands and face anywhere, anytime. Made with our No More Tears Formula, these wipes are as gentle to babys eyes as pure water.Johnsons Hand & Face Wipes were designed to gently and effectively remove dirt and germs from babys hands and face anywhere, anytime. Made with our No More Tears Formula, these wipes are as gentle to babys eyes as pure water.Johnsons Hand & Face Wipes were designed to gently and effectively remove dirt and germs from babys hands and face anywhere, anytime. Made with our No More Tears Formula, these wipes are as gentle to babys eyes as pure water.",
                        price: 6.20,
                        photo: "http://img2.targetimg2.com/wcsstore/TargetSAS//img/p/12/28/12286320.jpg",
                        upc: "381371027651")
camellia = Product.create(title: "Aubrey Organics - White Camellia Oil Soothing Emollient",
                          description: "Hand-harvested white camellia flower from Japan is the source of this nourishing oil, excellent for hair and skin care. A superb complexion oil, white camellia can be worn under a regular moisturizer for extra hydrating power, or applied directly to rough, dry areas of the skin to improve its texture. Applied to brittle hair and split ends, it replenishes lost moisture and leaves hair soft, lustrous and healthy-looking.",
                          price: 9.20,
                          photo: "http://ecx.images-amazon.com/images/I/418Q1YSG7PL._SL500_AA300_.jpg",
                          upc: "749985001106")
tea = Product.create(title: "Numi Organic Tea Chamomile Lemon, Herbal Teasan",
                    description: "A sweet and calming infusion of Egyptian chamomile flowers and bright, tangy lemon myrtle, an indigenous herb from the rainforests of Australia",
                    price: 12.24,
                    photo: "http://ecx.images-amazon.com/images/I/81uULS8tj1L._AA1500_.jpg",
                    upc: "680692101508")
republic = Product.create(title: "The Republic of Tea, Apricot Decaf Tea",
                          description: "Tart-sweet, somewhat musky flavor lends itself to the deep, rich notes of naturally decaffeinated black tea",
                          price: 7.30,
                          photo: "http://ecx.images-amazon.com/images/I/51dNOlDjLbL._SL500_AA300_.jpg",
                          upc: "742676440369")
glade = Product.create(title: "Glade 2 In1 Candle, Clean Linen/sunny Days",
                      description: "An oasis of calm. A blissful retreat from everyday tensions. Its important to find some quiet time every day for a little inner peace. So light a candle and let the calm begin.",
                      price: 4.99,
                      photo: "http://lh6.googleusercontent.com/public/CfV1OYOQ2BzBDddnslMxwd5bp-bJgIZ9b-bHPT8gXKSuRszsEDXdxywUC6f81C4kI9sfibQ61HxHwX0MKXgwp3PzmxlJaGA-1VGvO1T-wCwjXZMdcQE_F926aqvlSoKyYZhAygMIKDQZet8BvQ7MTnntEWJPlBML-9YXsr3kQeM",
                      upc: "046500724183")
gold = Product.create(title: "Gold Bond Baby Powder",
                      description: "Gold Bond cornstarch plus medicated baby powder helps prevent and treat diaper rash.",
                      price: 3.99,
                      photo: "http://ecx.images-amazon.com/images/I/21EWBvg-7aL._SL500_AA300_.jpg",
                      upc: "041167023044")
natures = Product.create(title: "Baby Powder Organic Unscented By Nature's Paradise 6 Oz",
                          description: "6 oz Baby Organic Powder is made with Organic Arrowroot powder which has a powdery soft texture to it which helps keep baby dry while soothing and softening the skin. No need to worry about your baby inhaling this powder as it is food grade and used in baking recipes. Absolutely no talc or chemicals that can endanger your little one. Other uses for baby powder besides on baby's tender little bottom is also in between baby rolls where sweat can gather and cause rashes as well as sweaty toes. Arrowroot powder is extremely fine and soft and works great for keeping baby dry. Great at absorbing moisture. This Baby Organic Powder is Talc Free",
                          price: 11.00,
                          photo: "http://ecx.images-amazon.com/images/I/41LX%2BVZB-gL._SL500_AA300_.jpg",
                          upc: "894921002089")
jbp = Product.create(title: "Johnson's Baby Powder",
                     description: "It's a classic. Johnson's Baby Powder helps to eliminate friction while keeping skin cool and comfortable. It's made of millions of tiny slippery plates that glide over each other to help reduce the irritation caused by friction.",
                     price: 2.99,
                     photo: "http://static-resources.goodguide.net/images/entities/large/138583.jpg",
                     upc: "381370030164")

CategoryAssignment.create(product: aqua, category: baby_products)
CategoryAssignment.create(product: aqua, category: beauty)
CategoryAssignment.create(product: chocolate, category: snacks)
CategoryAssignment.create(product: chocolate, category: gifts)
CategoryAssignment.create(product: now, category: beauty)
CategoryAssignment.create(product: toms, category: beauty)
CategoryAssignment.create(product: earth_mate, category: home)
CategoryAssignment.create(product: colgate, category: beauty)
CategoryAssignment.create(product: colgate, category: home)
CategoryAssignment.create(product: crust, category: snacks)
CategoryAssignment.create(product: quaker, category: snacks)
CategoryAssignment.create(product: california, category: baby_products)
CategoryAssignment.create(product: california, category: beauty)
CategoryAssignment.create(product: earth_baby, category: beauty)
CategoryAssignment.create(product: earth_baby, category: baby_products)
CategoryAssignment.create(product: bronner, category: gifts)
CategoryAssignment.create(product: bronner, category: beauty)
CategoryAssignment.create(product: aubrey, category: beauty)
CategoryAssignment.create(product: foam, category: beauty)
CategoryAssignment.create(product: johnson, category: beauty)
CategoryAssignment.create(product: camellia, category: beauty)
CategoryAssignment.create(product: tea, category: snacks)
CategoryAssignment.create(product: tea, category: gifts)
CategoryAssignment.create(product: republic, category: snacks)
CategoryAssignment.create(product: republic, category: gifts)
CategoryAssignment.create(product: glade, category: home)
CategoryAssignment.create(product: natures, category: baby_products)
CategoryAssignment.create(product: jbp, category: baby_products)

o1 = Order.create(user: matt, name: "matt yoho", address: "a cave", email: "matt@jumpstartlab.com", cc_number: "32131231242342", cc_expiry: "03/19", status: "pending")
o2 = Order.create(user: matt, name: "matt yoho", address: "a cave", email: "matt@jumpstartlab.com", cc_number: "32131231242342", cc_expiry: "03/19", status: "pending")
o3 = Order.create(user: matt, name: "matt yoho", address: "a cave", email: "matt@jumpstartlab.com", cc_number: "32131231242342", cc_expiry: "03/19", status: "shipped")
o4 = Order.create(user: matt, name: "matt yoho", address: "a cave", email: "matt@jumpstartlab.com", cc_number: "32131231242342", cc_expiry: "03/19", status: "shipped")
o5 = Order.create(user: matt, name: "matt yoho", address: "a cave", email: "matt@jumpstartlab.com", cc_number: "32131231242342", cc_expiry: "03/19", status: "paid")
o6 = Order.create(user: matt, name: "matt yoho", address: "a cave", email: "matt@jumpstartlab.com", cc_number: "32131231242342", cc_expiry: "03/19", status: "paid")
o7 = Order.create(user: jeff, name: "jeff casimir", address: "hungry academy", email: "jeff@jumpstartlab.com", cc_number: "8538147230423", cc_expiry: "09/14", status: "returned")
o8 = Order.create(user: jeff, name: "jeff casimir", address: "hungry academy", email: "jeff@jumpstartlab.com", cc_number: "8538147230423", cc_expiry: "09/14", status: "returned")
o9 = Order.create(user: jeff, name: "jeff casimir", address: "hungry academy", email: "jeff@jumpstartlab.com", cc_number: "8538147230423", cc_expiry: "09/14", status: "cancelled")
o10 = Order.create(user: jeff, name: "jeff casimir", address: "hungry academy", email: "jeff@jumpstartlab.com", cc_number: "8538147230423", cc_expiry: "09/14", status: "cancelled")

oi_1 = OrderItem.create(order: o1, product: jbp, quantity: 3)
oi_2 = OrderItem.create(order: o1, product: gold, quantity: 2)
oi_3 = OrderItem.create(order: o1, product: california, quantity: 2)
oi_4 = OrderItem.create(order: o2, product: foam, quantity: 1)
oi_5 = OrderItem.create(order: o2, product: johnson, quantity: 1)
oi_6 = OrderItem.create(order: o3, product: earth_baby, quantity: 3)
oi_7 = OrderItem.create(order: o3, product: tea, quantity: 4)
oi_8 = OrderItem.create(order: o4, product: earth_mate, quantity: 3)
oi_9 = OrderItem.create(order: o5, product: earth_baby, quantity: 1)
oi_10 = OrderItem.create(order: o5, product: now, quantity: 3)
oi_11 = OrderItem.create(order: o6, product: now, quantity: 8)
oi_12 = OrderItem.create(order: o7, product: tea, quantity: 3)
oi_13 = OrderItem.create(order: o7, product: earth_baby, quantity: 2)
oi_14 = OrderItem.create(order: o8, product: republic, quantity: 3)
oi_15 = OrderItem.create(order: o8, product: earth_mate, quantity: 3)
oi_16 = OrderItem.create(order: o9, product: now, quantity: 5)
oi_17 = OrderItem.create(order: o10, product: earth_mate, quantity: 8)
oi_18 = OrderItem.create(order: o10, product: republic, quantity: 3)

OrderItem.all.each do |oi|
  oi.set_price_from_product(oi.product)
  oi.save
end




