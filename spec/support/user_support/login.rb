module UserSupport
  module Login
    def login(user)
       visit '/login'
       fill_in 'user[email]', :with => user.email
       fill_in 'user[password]', :with => "mike"
       click_button("Sign In")
    end
  end
end