require 'spec_helper'

describe UsersController do
  describe "GET#show" do
    it 'returns a page with users account details' do
      get :show, :id => User.first
      response.should render_template(:show)
    end
  end
end
