module UserSupport
  module Login
    def login(user)
       visit '/login'
       fill_in 'email', :with => user.email
       fill_in 'password', :with => "password"
       click_button("Log in")
    end
  end
end