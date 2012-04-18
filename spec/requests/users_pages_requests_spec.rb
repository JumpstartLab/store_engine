require 'spec_helper'

describe "User pages" do

  describe "index" do
    let!(:first_user) { Fabricate(:user, name: "Thor", email: "godofthunder@example.com") }
    let!(:second_user) { Fabricate(:user, name: "Bob", email: "bob@example.com") }
    let!(:third_user) { Fabricate(:user, name: "Ben", email: "ben@example.com") }
    before(:each) do      
      visit signin_path
      fill_in "Email",    with: first_user.email
      fill_in "Password", with: first_user.password
      click_button "Sign in"
      visit users_path
    end

    it "should have a title of 'All users'" do
      page.should have_selector('title', text: 'All users')
    end

    it "should list each user" do
      User.all.each do |user|
        page.should have_selector('li', text: user.display_name)
      end
    end

    describe "pagination" do
      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all)  { User.delete_all }

      it "should have a 'Next' button at the top of the screen" do
        page.should have_selector("a[rel$='next']")
      end

      it "should list each user" do
        User.all[0..2].each do |user|
          page.should have_selector('li', text: user.display_name)
        end
      end
    end

    describe "delete links" do
      it "shouldn't have a delete link if the signed in user is not an admin" do
        page.should_not have_link('delete')
      end
    end

    context "as an admin user" do
      let!(:admin) { FactoryGirl.create(:admin) }
      before(:each) do
        visit signin_path
        fill_in "Email",    with: admin.email
        fill_in "Password", with: admin.password
        click_button "Sign in"
        visit users_path
      end

      it "there should be a delete link for the first user on the Users page" do
        page.should have_link('delete', href: user_path(User.first))
      end

      it "should be able to delete another user" do
        expect { click_link('delete')}.to change(User, :count).by(-1)
      end

      it "should not be able to delete the admin account" do
        page.should_not have_link('delete', href: user_path(admin))
      end
    end
  end


  describe "signup page" do
    before(:each) do
      visit signup_path
    end

    it "should have signup page headers and title" do
      page.should have_selector('h1', text: 'Sign up')
      page.should have_selector('title', text: 'Sign up')
    end

    context "with invalid signup information" do
      it "should not create a new user" do
        expect { click_link_or_button "Create my account" }.not_to change(User, :count)
      end
    end

    context "with valid signup information" do

      before(:each) do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "foobarbaz@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a new user" do
        expect { click_link_or_button "Create my account" }.to change(User, :count).by(1)
      end

      context "after saving the user" do
        before(:each) do
          click_link_or_button "Create my account"
        end

        let(:user) { User.find_by_email('foobarbaz@example.com') }

        it "should have a title including the user's name" do
          page.should have_selector('title', text: user.name)
        end

        it "should have the welcome alert message" do
          page.should have_selector('div.alert.alert-success', text: 'Welcome')
        end

        it "should have sign out link" do
          page.should have_link('Sign out', href: signout_path)
        end

        context "followed by signout" do
          before(:each) do
            click_link_or_button 'Sign out'
          end

          it "should have a sign in link" do
            page.should have_link('Sign in')
          end
        end
      end
    end
  end

  describe "profile page" do
    let!(:user) { Fabricate(:user) }
    before(:each) do
      visit user_path(user)
    end

    it "should have the display name of the user for the header and page title" do
      page.should have_selector('h1', text: user.display_name)
      page.should have_selector('title', text: user.name)
    end
  end

  describe "edit" do
    let!(:user) { Fabricate(:user) }
    before(:each) do
      visit signin_path
      fill_in "Email",    with: user.email
      fill_in "Password", with: user.password
      click_button "Sign in"
      visit edit_user_path(user)
    end

    describe "page" do
      it "should have an update profile header" do
        page.should have_selector('h1', text: "Update your profile")
      end

      it "should have an 'Edit user' title" do
        page.should have_selector('title', text: "Edit user")
      end

      it "should have a change user profile icon link" do
        page.should have_link('change', href: 'http://gravatar.com/emails')
      end

      context "with invalid information" do
        before(:each) do
          click_link_or_button "Save changes"
        end

        it "should display an error message" do
          page.should have_content('error')
        end
      end

      context "with valid information" do
        let(:new_name)  { "New Name" }
        let(:new_email) { "new@example.com" }
        
        before(:each) do
          fill_in "Name",             with: new_name
          fill_in "Email",            with: new_email
          fill_in "Password",         with: user.password
          fill_in "Confirm Password", with: user.password
          click_link_or_button "Save changes"
        end

        it "should have a title of the user who was changed" do
          page.should have_selector('title', text: new_name)
        end

        it "should have a successful change alert message" do
          page.should have_selector('div.alert.alert-success')
        end

        it "should have a Sign out link" do
          page.should have_link('Sign out', href: signout_path)
        end

        specify { user.reload.name.should == new_name }
        specify { user.reload.email.should == new_email }

      end
    end
  end
end