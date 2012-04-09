
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all
User.create(full_name: 'Matt Yoho', email_address: 'matt.yoho@livingsocial.com', display_name: '')