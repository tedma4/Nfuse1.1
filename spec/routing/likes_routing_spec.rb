require 'spec_helper'

describe 'Shouts', type: :routing do
  it 'keeps original routes' do
    # expect( get like_shout_path(id: 1) ).not_to be_routable
    expect( post like_shout_path(id: 1) ).to be_routable
    expect( post like_shout_path(id: 1) ).to route_to('shouts/likes#create', id: '1')
    expect( delete dislike_shout_path(id: 1) ).to route_to('shouts/likes#destroy', id: '1')
  end
end

describe 'Events', type: :routing do
  it 'keeps original routes'
end