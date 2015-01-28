require 'spec_helper'

describe ConversationsController, type: :controller do

  describe "GET 'create'" do
    let(:user) { create :user }

    before(:each) do
      login user
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
    let(:user) { create :user }
    let(:second_user) { create :user }
    let(:convo) { Conversation.create( sender_id: user.id, recipient_id: second_user.id) }

    before(:each) do
      @conversation = convo
    end

    it "returns http success" do
      login user
      get 'show', id: @conversation.id
      response.should be_success
    end
  end

end
