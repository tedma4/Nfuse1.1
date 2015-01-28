require 'spec_helper'

describe ConversationsController, type: :controller do
  let(:user) { create :user }


  describe "GET 'create'" do
    before(:each) do
      login user
      request.host = 'nfuse.com'
    end

    it "returns http success" do
      user_one = create :user
      post 'create', sender_id: user.id, recipient_id: user_one.id
      expect(request.params).to be_a Hash
      expect(request.params).to have_key(:sender_id)
      expect(request.params).to have_key(:recipient_id)
      expect(assigns[:conversation]).to be_a Conversation
    end

  end

  describe "GET 'show'" do

    let(:second_user) { create :user }
    let(:convo) { create(:conversation, sender_id: user.id) }

    before(:each) do
      @conversation = convo
      request.host = 'nfuse.com'
    end

    it 'Only returns my conversations' do
      conversation_two = create(:conversation)
      # two seperate users ^
      other_user = create :user
      login other_user
      # new user logged_in with ^
      current_user = User.find(request.session[:user_id])
      expect(conversation_two.sender).not_to    eq current_user
      expect(conversation_two.recipient).not_to eq current_user
      expect { get 'show', id: conversation_two.id }.not_to raise_error

      expect(response).to redirect_to root_url
    end

    it "returns http success" do
      login user
      get 'show', id: @conversation.id
      response.should be_success
    end
  end

end
