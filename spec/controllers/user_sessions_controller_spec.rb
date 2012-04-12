require 'spec_helper'

describe UserSessionsController do

  describe "GET 'login'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

end
