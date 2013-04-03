require 'spec_helper'

describe UsersController do
  describe "new" do
    it 'returns the new page' do
      get :new
      response.should be_success
    end
  end

  describe "POST#create" do
    pending
  end

  describe "GET#show" do
    context 'when a user is logged in' do

      before(:each) do
        @user = FactoryGirl.create(:user)
        login_user @user
      end

      it 'assigns the correct user' do
        get :show
        assigns(:user).should eq @user
      end

       it 'returns a page with users account details' do
        get :show
        response.should render_template(:show)
      end
    end

    context 'when a user is NOT logged in' do
      render_views
      it 'redirects them to the home page' do
        get :show
        response.should redirect_to(root_path)
      end
    end
  end
end
