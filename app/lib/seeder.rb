class Seeder

  def self.build_db
    build_users
    build_categories
    build_products(20)
    build_orders
  end

  def self.at_least_two(max)
    rand(max-1)+2
  end

  def self.at_least_one(max)
    rand(max)+1
  end

  def self.build_orders
    [ 'pending', 'paid', 'shipped', 'cancelled' ].each do |status_i|
      Seeder.at_least_two(4).times do
        order = Order.new
        order.user = User.first(:offset => rand( User.count ))

        Seeder.at_least_one(3).times do
          product = Product.first(:offset => rand( Product.count ))
          order.order_products.build(:price => product.price, :product => product, :quantity => Seeder.at_least_one(3))
        end
      order.save
      order.order_status.update_attribute(:status, status_i)
      end
    end
  end

  def self.build_products(quantity)
    quantity.times do
      x = Product.create( name: "The #{Faker::Name.name}", description: Faker::Lorem.paragraph(3), price: (15 + rand(10) + rand(4)*0.25) )
      (rand(3) + 1).times do
        offset = rand(Category.count)
        x.add_category(Category.first(:offset => offset))
      end
    end
  end

  def self.build_categories
    # should be:
    # [h,s,m].each do ...
    Category.create( name: 'Hats' )
    Category.create( name: 'Scarves' )
    Category.create( name: 'Mittens' )
    Category.create( name: 'Boots' )
    Category.create( name: 'Coats' )
  end

  def self.build_users
    User.create( name: 'Matt Yoho', email: 'demo08+matt@jumpstartlab.com', password: 'hungry')
    User.create( name: 'Jeff', display_name: 'j3', email: 'demo08+jeff@jumpstartlab.com', password: 'hungry')
    admin = User.create( name: 'Chad Fowler', display_name: 'SaxPlayer', email: 'demo08+chad@jumpstartlab.com', password: 'hungry')
    admin.update_attribute(:admin, true)
  end

  def self.destroy_db
    User.destroy_all
    Product.destroy_all
    Category.destroy_all
    Order.destroy_all
  end

end