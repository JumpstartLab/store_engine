# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def user(values)
  u =     User.create(
           :name  => values[0], :password => values[1], 
           :email => values[2], :display_name => values[3]
          )
  u.permission = values[4] if values[4]
  u.save
  u
end

def product(values)
  p =           Product.create(
                  :name => values[0], :description => values[1],
                  :price => values[2], :avatar_from_url => values[3], 
                )
  p.categories = values[4] if values[4]
  p.save
  p
end
def order(values)
  Order.create(
                :user => values[0], :status => values[1],
                :products => values[2], :is_cart => false
              )
end
u1 = user(["Mike Silvis", "mike", "mikesilvis@gmail.com", "mike", 9])
u2 = user(["Nisarg Shah", "nisarg", "nisargshah100@gmail.com", "nisarg", 9])
user(["Matt Yoho", "hungry", "demoXX+matt@jumpstartlab.com", ""])
user(["Jeff", "hungry", "demoXX+jeff@jumpstartlab.com", "j3"])
user(["Chad Fowler", "hungry", "demoXX+chad@jumpstartlab.com", "SaxPlayer", 9])

s1 = Status.create(   :name => "shipped"  )
s2 = Status.create(   :name => "pending"  )
s3 = Status.create(   :name => "cancelled")
s4 = Status.create(   :name => "paid"     )
s5 = Status.create(   :name => "returned" )

c1 = Category.create( :name => "Music"    )
c2 = Category.create( :name => "Toys"     )
c3 = Category.create( :name => "Electronics")
c4 = Category.create( :name => "Relaxation")
c5 = Category.create( :name => "Water")
c6 = Category.create( :name => "Computer")
c7 = Category.create( :name => "PIMP")
c8 = Category.create( :name => "Clothes")
c9 = Category.create( :name => "Traveling Devices")
c10 = Category.create( :name => "Personal")
c11 = Category.create( :name => "Office")

p1 = product(["Nintendo", "DUCK HUNTER!!!", "9999.00", "http://images.sodahead.com/polls/001017851/nes_xlarge.jpeg"])
p2 = product(["iPod", "Carry up to 300 songs in your pocket!", "99.75", "http://goo.gl/3gfMb", [c1, c2, c3, c6]])
p3 = product(["Racecar", "VRRRRRRRRRMMMMMMM", "20.65", "http://goo.gl/REU7v", [c2]])
p4 = product(["PDA", "Check Yo email while you.... That's about all i can do.", "199.65", "http://goo.gl/O6g9m", [c3,c2]])
p5 = product(["Basketball", "I'm gonna dunk on you", "14.95", "http://goo.gl/wuYFI", [c2]])
p6 = product(["Hot Tub", "I know why you are buying me you perv...", "1400.95", "http://goo.gl/0nYrv", [c4,c5]])
p7 = product(["Macbook Pro", "The best computers on earth", "2000.91", "http://goo.gl/MI75I", [c3,c2,c6]])
p8 = product(["Keyboard", "Balling oldschool keyboard.", "2.91", "http://goo.gl/a0Sse", [c3,c6]])
p9 = product(["Mouse", "I don't need all that fancy shiz, just give me a pointer.", "23.91", "http://goo.gl/4Cacm", [c3,c6]])
p10 = product(["Speakers", "Yeah we have speakers made out of trees", "263.91", "http://goo.gl/tjQn3", [c3,c6]])

p11 = product(["Camera", "This awesome device will allow you to record an instance in time forever!", "234", "http://goo.gl/n8l1m", [c3]])
p12 = product(["Record Player", "This + Barry white = Good Time", "204", "http://goo.gl/nRIzE", [c1]])
p13 = product(["Disco Ball", "So you can ball while you disco", "19.99", "http://goo.gl/VOlV6", [c2, c7]])
p14 = product(["Sewing Machine", "Your not a true hipster unless you sew your clothes back together with this hipster sewing machine", "190.99", "http://goo.gl/nvuLQ", [c2, c8]])
p15 = product(["Plane", "WW2 Plane, i know what your thinking and yes this thing does still fly.", "2342.99", "http://goo.gl/92NGI", [c3, c9]])
p16 = product(["Razor", "To trim that hispter stash...", "2.99", "http://goo.gl/GhwHX", [c4, c10]])
p17 = product(["Glasses", "When you can't see, put these bad boys on", "9.99", "http://goo.gl/jWXGm", [c10]])
p18 = product(["Pen", "When you have lots to write, use this bad boy. It was used to write the constitution", "6.99", "http://goo.gl/4mrfy", [c10, c9, c11]])
p19 = product(["Video Camera", "Study how a horse runs with this motion camera", "69.99", "http://goo.gl/bZaow", [c1, c3]])
p20 = product(["Baller Shoes", "Jump up to 5 feet higher with these things on", "199", "http://goo.gl/1sQB8", [c10, c8]])

Sale.create(:percent_off => 30, :end_at => 30.days.from_now, :categories => [c1])
Sale.create(:percent_off => 60, :end_at => 30.days.from_now, :categories => [c11])
Sale.create(:percent_off => 90, :end_at => 30.days.from_now, :products => [p1,p2,p20])

o1 = order([u1, s1, [p1, p2]])
o2 = order([u1, s2, [p1, p3]])
o2 = order([u2, s4, [p1, p3]])