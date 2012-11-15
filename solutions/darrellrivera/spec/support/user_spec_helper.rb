module UserHelper
  def fill_product_form
    product = build_product

    fill_in "Title", :with => product[:title]
    fill_in "Description", :with => product[:description]
    fill_in "Price", :with => product[:price]
    fill_in "Photo", :with => product[:photo]
  end

  def build_product
    {
      :title => Faker::Lorem.words(rand(3)).map(&:capitalize).join(" "),
      :description => Faker::Lorem.paragraph,
      :price => (100 * rand).round(2) + 10,
      :photo => Faker::Internet.url
    }
  end

  def create_user(user)
    visit signup_path
    complete_user_form(user)
    click_button "Create User"
  end

  def complete_user_form(user)
    fill_in "Name", :with => user.name
    fill_in "Username", :with => user.username
    fill_in "Email", :with => user.email
    fill_in "Password",
      :with => Fabricate.attributes_for(:user)[:password]
    fill_in "Password confirmation",
      :with => Fabricate.attributes_for(:user)[:password]
  end

  def login_as(user)
    visit login_path

    fill_in "Email", :with => user.email
    fill_in "Password", :with => Fabricate.attributes_for(:user)[:password]

    click_button "Log in"
  end

  def fill_billing_form
    billing = build_billing
    fill_in "Credit card number", :with => billing[:credit_card_number]
    fill_in "Cvc", :with => billing[:cvc]
    fill_in "Expiration date", :with => billing[:expiration_date]
    fill_billing_address(billing[:address])
  end

  def fill_billing_address(address)
    fill_in "Street", :with => address[:street]
    fill_in "City", :with => address[:city]
    fill_in "State", :with => address[:state]
    fill_in "Zipcode", :with => address[:zipcode]
  end

  def build_billing
    {
      :credit_card_number => "1234123412341234",
      :cvc => "123",
      :expiration_date => "04/15",
      :address => {
        :street => "123 Jonan Street",
        :city => "Jonanville",
        :state => "MD",
        :zipcode => "12345"
      }
    }
  end
end
