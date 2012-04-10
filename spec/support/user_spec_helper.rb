module UserHelper
  def fill_product_form
    title = Faker::Lorem.words(rand(1..3)).map(&:capitalize).join(" ")
    description = Faker::Lorem.paragraph
    price = (100 * rand).round(2) + 10
    photo = Faker::Internet.url

    fill_in "Title", :with => title
    fill_in "Description", :with => description
    fill_in "Price", :with => price
    fill_in "Photo", :with => photo
  end

  def create_user(user)
    visit signup_path

    fill_in "Name", :with => user.name
    fill_in "Username", :with => user.username
    fill_in "Email", :with => user.email
    fill_in "Password", :with => Fabricate.attributes_for(:user)[:password]
    fill_in "Password confirmation", :with => Fabricate.attributes_for(:user)[:password]

    click_button "Create User"
  end

  def login_as(user)
    visit login_path

    fill_in "Email", :with => user.email
    fill_in "Password", :with => Fabricate.attributes_for(:user)[:password]

    click_button "Log in"
  end
end