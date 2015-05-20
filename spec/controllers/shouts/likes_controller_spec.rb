require 'spec_helper'

describe Shouts::LikesController, type: :controller do

  before(:each) do
    @shout = create :shout
    login @shout.user
  end

  it 'It should create a like' do
    expect(@shout).to be_valid
    count = Twitter::Vote.count
    post :create, id: @shout.id, key: 'twitter'
    expect( response ).to be_success
    expect(Twitter::Vote.count).to eq count+1
  end

  it 'It should remove Likes on the Shout.' do
    expect { post :create, id: @shout.id, key: 'facebook' }.to change(Facebook::Vote, :count)
    delete :destroy, id: @shout.id
    expect(assigns(:like)).to be_a ActsAsVotable::Vote
    expect(response).to be_success
  end

end
