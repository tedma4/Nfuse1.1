require 'rails_helper'

RSpec.describe Users::NfusedPagesController, :type => :controller do

  context 'nfusing a post' do

    before(:each) do
      @user = create(:user)
      request.host = 'nfuse.com'
    end

    context 'Regular shout' do
      it 'accepts all needed params' do
        shout = create(:shout)
        post :create, id: shout.id, user_id: @user.id, owner_id: @user.id
        %w( id user_id owner_id ).each { |key|
          expect(request.params).to have_key(key.to_sym)
        }
        expect(assigns(:nfuse_page)).to be_a NfusePage
        expect(assigns(:nfuse_page)).to be_persisted
        expect(assigns(:nfuse_page).social_key).to eq('nfuse')
        expect(response.status).to eq 200
      end
    end

    context '#Twitter' do
      it 'accepts all needed params' do
        shout = create(:shout)
        post :create, id: shout.id, user_id: @user.id, owner_id: @user.id, key: 'twitter'
        %w( id user_id owner_id key).each { |key|
          expect(request.params).to have_key(key.to_sym)
        }
        expect(assigns(:nfuse_page)).to be_a NfusePage
        expect(assigns(:nfuse_page)).to be_persisted
        expect(assigns(:nfuse_page).social_key).to eq('twitter')
        expect(response.status).to eq 200
      end
    end

    context 'youtube' do

    end

  end
end
