require 'spec_helper'

describe 'auth/ #routing', type: :routing do

  it 'Auth Routing' do
    expect(get('/auth/instagram/callback')).to route_to('instagram_registration#create')
    expect(get('/auth/twitter/callback')).to route_to('twitter_registration#create')

    expect(get('/auth/facebook/callback')).to route_to('facebook_registration#create')
    expect(get('/auth/failure')).to route_to('twitter_registration#failure')
  end

end