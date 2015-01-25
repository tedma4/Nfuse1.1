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
