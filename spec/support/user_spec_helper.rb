class UserHelper
  def self.fill_product_form
      title = Faker::Lorem.words(rand(1..3)).map(&:capitalize).join(" ")
      description = Faker::Lorem.paragraph
      price = (100 * rand).round(2) + 10
      photo = Faker::Internet.url
      
      fill_in "Title", :with => title
      fill_in "Description", :with => description
      fill_in "Price", :with => price
      fill_in "Photo", :with => photo
  end
end