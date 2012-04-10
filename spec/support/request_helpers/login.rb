module RequestHelpers
  module Login
    def login(email, password)
      within("#session") do
        fill_in 'Email', :with => email
        fill_in 'Password', :with => password
        click_link 'Sign-In'
      end
    end
  end
end
