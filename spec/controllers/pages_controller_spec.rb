require 'spec_helper'

describe PagesController, type: :controller do

  describe "GET 'home'" do
    let(:me) { create(:user) }
    before(:each) do
      request.host = 'nfuse.com'
      login me
    end

    context 'logged in' do
      it 'should maintain all instance vars' do
        get 'home'
        # be(me) fails because it looks for exact * User object _id
        expect(assigns[:user]).to eql(me)
        expect(response).to be_success
      end
    end

    context 'logged out' do
      it "returns http success" do
        log_out
        get 'home'
        expect(response).to redirect_to signin_url
        end
    end

  end

end
