require 'spec_helper'

describe Feed do
  describe '#construct' do
    let(:shout) { create(:shout) }
    let(:user) { create(:user) }
    let(:feed) { Feed.new(user) }
    before { user.shouts << shout }
    it 'should accept params hash in initialize' do
      expect(feed).to respond_to(:construct)
      expect(feed.construct({})).to be_a Array
    end

    describe 'construct internals' do
      pending '#twitter_posts api call'
      pending '#facebook_posts api call'
      pending '#instagram_posts api call'
      pending '#users_posts api call'
    end
  end
end

