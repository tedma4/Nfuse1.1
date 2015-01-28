require 'spec_helper'

describe PagesController, type: :controller do

  describe "GET 'home'" do
    render_views

    let(:me) { create(:user) }
    let(:user_num) {rand(10)+1} # to make sure its not 0
    let(:this_user) { create(:user) }
    let(:multiple_follows) { user_num.times do this_user.follow! create(:user); end }


    before(:each) do
      request.host = 'nfuse.com'
      login me
    end

    context 'logged in' do

      it 'should maintain all instance vars' do
        get 'home'
        # be(me) fails because it looks for exact * User object _id
        expect(assigns[:current_user]).to eql(me)
        expect(assigns[:timeline]).to be_an Array
        expect(response).to render_template :home
        expect(response).to be_success
      end

      it "should render correct partial timeline" do
        get 'home'
        expect(response).to render_template(partial: '_timeline')
        expect(response).not_to render_template(partial: '_landing')
      end
    end

    context 'logged out' do
      it "STILL * returns http success" do
        log_out
        get 'home'
        expect(response).to be_success
        expect(response).to render_template :home
      end

      it 'DOES NOT render timeline partial' do
        log_out
        get 'home'
        expect(response).not_to render_template(partial: '_timeline')
        expect(response).to render_template(partial: '_landing')
      end
    end

  end

end
