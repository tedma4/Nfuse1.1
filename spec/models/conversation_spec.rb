require 'spec_helper'

describe Conversation do
  let(:user)  { create(:user) }
  let(:convo) { create(:conversation, sender_id: user.id) }
  
  it 'is between two users' do
    expect(convo.recipient).not_to eq(user)
    expect(convo.sender).to eq(user)
  end

end
