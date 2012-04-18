require 'spec_helper'

describe "AuthenticationPages" do

  describe "signin page" do
    before(:each) do
      visit signin_path
    end

    it "should have signin page headers and title" do
      page.should have_selector('h1', text: 'Sign in')
      page.should have_selector('title', text: 'Sign in')
    end

    describe "signin" do
      before(:each) do
        visit signin_path
      end

      context "with invalid information" do
        before(:each) do
          click_link_or_button "Sign in"
        end

        it "should have signin page headers and title" do
          page.should have_selector('h1', text: 'Sign in')
        end
      end

      context "after visiting another page" do
        before { click_link_or_button "Sign up now!" }

        it "should not have any login failer alert message" do
          page.should_not have_selector('.alert alert-error')
        end
      end

      context "with valid information" do
        let(:user) { FactoryGirl.create(:user) }
        before do
          fill_in "Email",    with: user.email
          fill_in "Password", with: user.password
          click_button "Sign in"
        end

        it "should have the user's name set as the title of the page" do
          page.should have_selector('title', text: user.name)
        end

        it "should have a link to the 'All Users' page" do
          page.should have_link('Users', href: users_path)
        end

        it "should have a link to the user's profile page" do
          page.should have_link('Profile', href: user_path(user))
        end

        it "shoulud have a link to edit the user's profile" do
          page.should have_link('Settings', href: edit_user_path(user))
        end

        it "should have a sign-out link" do
          page.should have_link('Sign out', href: signout_path)
        end

        it "should not have a sign-in link" do
          page.should_not have_link('Sign in', href: signin_path)
        end
      end
    end
  end

  describe "authorization" do

    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
      
      before do
        visit signin_path
        fill_in "Email",        with: user.email
        fill_in "Password",     with: user.password
        click_link_or_button "Sign in"
      end

      context "visiting Users#edit page" do
        before { visit edit_user_path(wrong_user) }

        it "should not be accessible to the incorrect user" do
          page.should_not have_selector('title', text: 'Edit user')
        end
      end

      context "submitting a PUT request to the Users#update action" do
        before(:each) do
          put user_path(wrong_user)
        end

        it "should not be able to successfully submit a put request to the incorrect user" do
          response.should redirect_to(signin_path)
        end
      end
    end

    describe "as non-admin user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:non_admin) { FactoryGirl.create(:user) }

      before(:each) do
        visit signin_path
        fill_in "Email",        with: non_admin.email
        fill_in "Password",     with: non_admin.password
        click_link_or_button "Sign in"
      end

      context "submitting a delete request to the Users#destroy action" do
        before { delete user_path(user) }
        specify { response.should redirect_to(signin_path) }
      end
    end

    describe "for non-signed-in users" do
      let!(:user) { Fabricate(:user) }

      describe "when attempting to visit a protected page" do
        before do
          visit edit_user_path(user)
          fill_in "Email",    with: user.email
          fill_in "Password", with: user.password
          click_button "Sign in"
        end

        describe "after signing in" do
          it "should render the desired protected page" do
            page.should have_selector('title', text: 'Edit user')
          end
        end
      end

      describe "in the Users controller" do

        describe "visting the user index" do
          before(:each) do
            visit users_path
          end

          it "should re-route non-signed in users to the signin page" do
            page.should have_selector('title', text: 'Sign in')
          end
        end

        describe "visiting the edit page" do
          before(:each) do
            visit edit_user_path(user)
          end

          it "should default to a signin page" do
            page.should have_selector('title', text: 'Sign in')
          end
        end

        describe "submitting to the update action" do
          before(:each) do
            put user_path(user)
          end

          specify { response.should redirect_to(signin_path) }
        end
      end
    end
  end
end
