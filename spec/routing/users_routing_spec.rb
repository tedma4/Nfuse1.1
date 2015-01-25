require 'spec_helper'

describe '/users/*', type: :routing do

  context '#home page' do
    it 'pages controller' do
      expect(get('/')).to route_to('pages#home')
    end
  end

  context 'registration and authentication' do

    it '/signUp path' do
      expect(get(signup_path)).to route_to('users#new')
      expect(get(signup_url)).to route_to('users#new')
    end

    it '/signIn path' do
      expect(get(signin_path)).to route_to('sessions#new')
      expect(get(signin_url)).to route_to('sessions#new')
    end

    it '/signOut path' do
      expect(delete(signout_path)).to route_to('sessions#destroy')
      expect(delete(signout_url)).to route_to('sessions#destroy')
    end
  end

  context 'settings' do
    
    it '/settings path' do
      expect(get(settings_path)).to route_to('users#settings')
      expect(get(settings_url)).to  route_to('users#settings')
    end
    
  end

end