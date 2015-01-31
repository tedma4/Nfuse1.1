require 'spec_helper'

describe 'auth/ #routing', type: :routing do

  it 'Auth Routing' do
    expect(get('/auth/instagram/callback')).to route_to('registrations/instagram#create')
    expect(get('/auth/twitter/callback')).to route_to('registrations/twitter#create')
    expect(get('/auth/facebook/callback')).to route_to('registrations/facebook#create')
    expect(get('/auth/failure')).to route_to('registrations/twitter#failure')
  end

end