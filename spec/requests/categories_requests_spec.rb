describe "Categories Requests" do
  context "when I add a category" do
    let!(:user) { Fabricate(:user, :admin => true)}

    it "works" do
      login
      visit new_admin_category_path
      fill_in("Name", :with => "New category")
      click_button("Create Category")
      page.should have_content("New category")
    end
  end
end
