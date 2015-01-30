require 'spec_helper'

describe Conversation do
  it { is_expected.to belong_to(:sender).with_foreign_key(:sender_id).class_name('User') }
  it { is_expected.to belong_to(:recipient).with_foreign_key(:recipient_id).class_name('User') }

  let(:user)  { create(:user) }
  let(:convo) { create(:conversation, sender_id: user.id) }
  
  it 'is between two users' do
    expect(convo.recipient).not_to eq(user)
    expect(convo.sender).to eq(user)
  end

  it '#involving' do
    me = create(:user)
    first   = create(:conversation, recipient_id: me.id)
    second  = create(:conversation, sender_id: me.id)
    third   = create(:conversation, recipient_id: me.id)
    fourth   = create(:conversation, sender_id: me.id)

    count = (rand(10)+1)
    others = []
    count.times do
      others << create(:conversation)
    end
    expect(others.sample).to be_a Conversation
    expect(Conversation.count).to eq(count+4)
    expect(Conversation.involving(me)).to be_a ActiveRecord::Relation
    expect(Conversation.involving(me)).not_to include(others.sample)
    expect(Conversation.involving(me)).to include(first)
  end

end
