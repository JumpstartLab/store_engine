require 'spec_helper'

describe "Categories Requests" do
  let!(:categories) { [Fabricate(:category), Fabricate(:category)] }
  let!(:admin_user) { Fabricate(:admin_user) }

end