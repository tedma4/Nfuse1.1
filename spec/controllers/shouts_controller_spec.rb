require 'spec_helper'

describe ShoutsController, type: :controller do

  describe 'create' do

    before(:each) do 
      login create :user
    end

    it 'creates the shout obj' do
      post :create, shout: valid_shout
      # puts valid_shout 
      expect(assigns(:shout)).to be_a Shout
      expect(assigns(:shout).is_pic).to be_truthy
      expect(assigns(:shout).is_video).to be_falsy
      expect(assigns(:shout).is_link).to be_falsy
    end

    def valid_shout
      pic = Rack::Test::UploadedFile.new('spec/factories/images/one.jpg', 'image/jpg')
      { pic: pic }
    end

  end

  context 'Liking' do
  end
end
