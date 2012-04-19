# This file should contain all the record creation
# needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed
# (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
matt = User.create(:first_name => "Matt",
                   :last_name => "Yoho",
                   :email => "demo07+matt@jumpstartlab.com",
                   :password => "hungry")

jeff = User.create(:first_name => "Jeff",
                   :last_name => "",
                   :email => "demo07+jeff@jumpstartlab.com",
                   :password => "hungry",
                   :display_name => "j3")

chad = User.new(:first_name => "Chad",
                   :last_name => "Fowler",
                   :email => "demo07+chad@jumpstartlab.com",
                   :password => "hungry",
                   :display_name => "SaxPlayer")

chad.admin = true
chad.save

# active products
scotch = Product.create(:title => "Shackleton Scotch",
        :description => "Really old, yet awesome scotch",
        :price => "3000.00",
        :remote_image_url =>
        "http://media-cache6.pinterest.com/upload/75998312432081829_lI6HCbKt_f.jpg")

badger_portrait = Product.create(:title => "Motivational Badger Portrait",
        :description => "Portrait of the Musteliade as an old man.",
        :price => "25.00",
        :remote_image_url =>
        "http://media-cache0.pinterest.com/upload/205406432974085111_NMFohM3U_f.jpg")

sandwich = Product.create(:title => "Meatwich",
        :description => "Carrots just for color. Do not eat. Expedited delivery available.",
        :price => "5.00",
        :remote_image_url =>
        "http://media-cache4.pinterest.com/upload/285415695104705258_BEwtiQgT_f.jpg")

grill = Product.create(:title => "Black Dog Grill & Smoker",
        :description => "The best cooking experience ever",
        :price => "520.00",
        :remote_image_url =>
        "http://media-cache7.pinterest.com/upload/226798531204673845_mGTy9IGL_f.jpg")

lamp = Product.create(:title => "Terrarium Light",
        :description => "Aesthetic illuminary or Grow-House Accessory - you decide.",
        :price => "120.00",
        :remote_image_url =>
        "http://media-cache4.pinterest.com/upload/206110120416359988_2pOBkRCW_f.jpg")

taxider_variety = Product.create(:title => "Taxidermy Variety Pack",
        :description => "It's taxidermy all the way down. A great way to start your collection",
        :price => "375.99",
        :remote_image_url =>
        "http://media-cache3.pinterest.com/upload/255720085061108120_vndr1MXe_f.jpg")

electric_eraser = Product.create(:title => "Electric Eraser",
        :description => "For life's colossal mistakes.",
        :price => "50.00",
        :remote_image_url =>
        "http://media-cache1.pinterest.com/upload/135600638749839843_HG55OePH_f.jpg")

taxidermy_guitar = Product.create(:title => "Rock Band Squirrel",
        :description => "This is the classic Les Paul model. Keytar edition extra.",
        :price => "152.40",
        :remote_image_url =>
        "http://media-cache6.pinterest.com/upload/76420524897178260_fBV1zi2p_f.jpg")

garden_tools = Product.create(:title => "Garden Tools",
        :description => "Goes great with the Terrarium Lamp.",
        :price => "60.00",
        :remote_image_url =>
        "http://media-cache2.pinterest.com/upload/42502790203553937_CNmsH1OC_f.jpg")

badger_honor = Product.create(:title => "Badger of Honor",
        :description => "Awarded to those having demonstrated exceptional commitment to King and Country.",
        :price => "10.00",
        :remote_image_url =>
        "http://media-cache3.pinterest.com/upload/23573598019544994_jrbFn2lm_f.jpg")

straight_razor = Product.create(:title => "Straight Razor",
        :description => "Wow, it's even in German.",
        :price => "35.00",
        :remote_image_url =>
        "http://media-cache7.pinterest.com/upload/114630752985516371_DFQMRNtq_f.jpg")

sideboard = Product.create(:title => "Side Board",
        :description => "Give me mahogany in ample supply. Great for displaying things, such as taxidermy collections.",
        :price => "1060.00",
        :remote_image_url =>
        "http://media-cache7.pinterest.com/upload/32017847320323682_Pr0voayj_f.jpg")

hammer = Product.create(:title => "Designer Hammer",
        :description => "Great for stubborn cufflinks.",
        :price => "75.00",
        :remote_image_url =>
        "http://media-cache4.pinterest.com/upload/55098795410642288_97j8fEnj_f.jpg")

badger_theremin = Product.create(:title => "Badger Theremin",
        :description => "Electronics + Taxidermy. Now in one convenient, furry package.",
        :price => "35.00",
        :remote_image_url =>
        "http://media-cache8.pinterest.com/upload/110127153358113430_7WChIRNy_f.jpg")

curiosity_cabinet = Product.create(:title => "Ichthyological Display",
        :description => "Get 'em now before Jonan microwaves them.",
        :price => "55.00",
        :remote_image_url =>
        "http://media-cache1.pinterest.com/upload/15551561182746233_a8zvhnDM_f.jpg")

badger_cufflinks = Product.create(:title => "Badger Cufflinks",
        :description => "No description needed. The instant order button is that way.",
        :price => "105.00",
        :remote_image_url =>
        "http://media-cache2.pinterest.com/upload/22447698112187000_kAyNQbbv_f.jpg")

projector = Product.create(:title => "Moving Picture",
        :description => "There's no lightning talk like a 10fps lightning talk.",
        :price => "405.00",
        :remote_image_url =>
        "http://media-cache0.pinterest.com/upload/102949541452031445_D5vlPabc_f.jpg")

firewood = Product.create(:title => "Firewood",
        :description => "Please inquire about shipping. Freshly hewn.",
        :price => "5.00",
        :remote_image_url =>
        "http://media-cache3.pinterest.com/upload/14425661275899160_iWY9Y4q8_f.jpg")

lantern = Product.create(:title => "Kerosene Lantern",
        :description => "LEDs just aren't reliable enough for the real man.",
        :price => "15.00",
        :remote_image_url =>
        "http://media-cache4.pinterest.com/upload/168955423490049825_MNuhq3DO_f.jpg")

carriage = Product.create(:title => "Carriage",
        :description => "They see me rollin'...",
        :price => "125000.00",
        :remote_image_url =>
        "http://media-cache9.pinterest.com/upload/11540542764883940_SVXxEJzX_f.jpg")


#inactive product


# create categories
furniture   = Category.create(:name => "Furniture")
accessory   = Category.create(:name => "Accessories")
tools       = Category.create(:name => "Tools")
badgers     = Category.create(:name => "Badgers")
comestibles = Category.create(:name => "Comestibles")
taxidermy   = Category.create(:name => "Taxidermy")
appliances  = Category.create(:name => "Appliances")
miscellany  = Category.create(:name => "Miscellany")

# fill categories

accessory.products   << [curiosity_cabinet, straight_razor, firewood, lantern]
furniture.products   << [sideboard, lamp]
tools.products       << [hammer, garden_tools, electric_eraser, projector]
badgers.products     << [badger_theremin, badger_cufflinks, badger_honor, badger_portrait]
comestibles.products << [sandwich, scotch]
taxidermy.products   << [taxidermy_guitar, taxider_variety]
appliances.products  << [grill, lantern, projector]
miscellany.products  << [carriage, firewood, curiosity_cabinet]

# make orders
20.times do |i|
  Fabricate(:order, :user_id => rand(3)+1)
  OrderProduct.create(:quantity => rand(10)+1,
                      :product_id => rand(4)+1,
                      :price => rand(25),
                      :order_id => i+1)
end

# make billing addresses
3.times do
  Fabricate(:order, :billing_address_id => rand(3)+1)
end

# make shipping addresses
2.times do
  Fabricate(:order, :shipping_address_id => rand(5)+1)
end

# make addresses
Fabricate(:address)
Fabricate(:address)
Fabricate(:address)
Fabricate(:address)
Fabricate(:address)
