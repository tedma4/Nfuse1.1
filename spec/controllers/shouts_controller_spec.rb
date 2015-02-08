require 'spec_helper'

describe ShoutsController, type: :controller do

  describe 'create' do
    let(:user) { create :user }

    before(:each) do 
      login user
    end

    it 'creates the shout obj' do
      post :create, shout: valid_shout.merge(user_id: user.id, content: 'What a badass pic...')
      # puts valid_shout 
      expect(assigns(:shout)).to be_a Shout
      shout = assigns(:shout)
      expect(shout.is_pic?).to be_truthy
      expect(shout.is_video).to be_falsy
      expect(shout.is_link).to be_falsy

    end

    def valid_shout
      pic = Rack::Test::UploadedFile.new('spec/factories/images/one.jpg', 'image/jpg')
      { pic: pic }
    end

  end
end
