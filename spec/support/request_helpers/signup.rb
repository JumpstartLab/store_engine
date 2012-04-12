module RequestHelpers
  module SignUp
    def sign_up(params)
      within(".new_user") do
        fill_in 'Full name', :with => params[:full_name]
        fill_in 'Email address', :with => params[:email]
        fill_in 'Display name', :with => params[:display_name]
        fill_in 'Password', :with => params[:password]
        fill_in 'Password confirmation', :with => params[:password]
        click_link_or_button 'Sign Up'
      end
    end
  end
end
