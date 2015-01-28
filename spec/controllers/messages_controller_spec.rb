require 'spec_helper'

describe MessagesController, type: :controller do

  describe "GET 'create'" do
    xit "returns http success" do
      get 'create'
      response.should be_success
    end
  end

end
