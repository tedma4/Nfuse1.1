require 'spec_helper'

describe RelationshipsController, type: :controller do

  before(:each) do
    login create(:user)
  end

  describe "GET 'create'" do
    xit "returns http success" do
      get 'create'
      response.should be_success
    end
  end

  describe "GET 'destroy'" do
    xit "returns http success" do
      get 'destroy'
      response.should be_success
    end
  end

end
