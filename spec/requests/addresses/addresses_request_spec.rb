describe "Address" do
let(:user)     { Fabricate(:user,
                    :password => 'password',
                    :admin => true)}

  context "adding an address" do
    before(:each) do
      login(user)
      visit user_path(user)
    end


  end

end