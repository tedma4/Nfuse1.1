require 'spec_helper'

describe Feed do
  describe '#construct' do
    let(:feed) { Feed.new(create(:user)) }

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

