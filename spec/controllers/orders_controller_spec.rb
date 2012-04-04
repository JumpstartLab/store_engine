require 'spec_helper'

describe OrdersController do

  describe "GET /orders" do
    it "should be successful" do
      get "index"
      response.should be_success
    end
  end

end
