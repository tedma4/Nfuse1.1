require 'spec_helper'

describe UsersController, type: :controller do

  describe "GET 'index'" do
    let(:user)  { create(:user) }
    
    before(:each) do
      request.host = 'nfuse.com'
      login user
    end

    after(:each) do
      log_out
    end

    context 'logged in' do
      it "returns http success" do
        get 'index'
        expect(assigns(:users)).to be_a ActiveRecord::Relation

        num = (rand(10)+1)
        num.times { create(:user) }

        expect(assigns[:users]).not_to include(user)
        expect(assigns[:users].count).to eq(num)
        expect(response).to be_success
      end
    end

    context '#logged out' do
      it 'redirects to login page' do
        log_out
        get 'index'
        expect(response).not_to be_success
        expect(response).to redirect_to signin_url
      end
    end

  end

  describe '#show' do

    let(:user)  { create(:user) }

    before(:each) do
      request.host = 'nfuse.com'
      login user
    end

    after(:each) do
      log_out
    end


    context 'logged in' do
      it 'returns user object from param[:id]' do
        get 'show', id: user.id
        expect(assigns[:user]).to eq user
      end

      it 'shows other user NOT logged in user' do
        other_user = create(:user)
        get 'show', id: other_user.id
        expect(assigns[:user]).to eq other_user
      end

      it 'maintains session id as logged_in not other_user' do
        # user = login user from before(:callback)
        other_user = create(:user)
        get 'show', id: other_user.id
        expect(User.find(request.session[:user_id])).to eq user
        expect(assigns[:current_user]).to eq user
      end
    end

    context 'not logged in' do
      it 'issues redirect' do
        log_out
        other_user = create(:user)
        get 'show', id: other_user.id
        expect(response).not_to be_success
        expect(response).to redirect_to signin_url
      end
    end
  end

  describe '#feed' do
    let(:user) { create :user }

    it 'maintains all old instance vars' do
      login user
      get 'feed', id: user.id
      expect(assigns[:timeline]).to be_a Array
      expect(assigns[:providers]).to be_a Providers
      expect(assigns[:unauthed_accounts]).to be_a Array
    end
  end

  describe "GET 'new'" do
    xit "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    xit "returns http success" do
      get 'show'
      response.should be_success
    end
  end

end
