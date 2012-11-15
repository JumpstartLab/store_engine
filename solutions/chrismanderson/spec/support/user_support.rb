module UserSupport
  def login(user)
    visit '/login'
    fill_in 'account_name', with: user.email
    fill_in 'password', with: user.password
    click_button("Log In")
  end
end