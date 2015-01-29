require 'spec_helper'

describe Token do
  # Associations
  it { is_expected.to belong_to :user }
  # Validations
  it { is_expected.to validate_presence_of :uid}
  it { is_expected.to validate_presence_of :provider }

  describe 'custom queries' do
    it 'Token.by_name' do
      expect(Token.by_name('string')).to be_a ActiveRecord::Relation
    end

    it 'can find or create token' do

      auth_hash = attributes_for(:token)
      # mock twitter_hash 
      AToken = Struct.new(:x) do 
        def token 
          SecureRandom.hex(20)
        end
        def secret
          SecureRandom.hex(20)
        end
      end
    provider  = ['twitter', 'instagram', 'facebook', 'youtube'].sample
    mock_hash = {
        'provider' => provider,
         'uid' => SecureRandom.hex(10),
         'extra' => { 'access_token' =>  AToken.new },
         'credentials' => {'token' => AToken.new.token }
      }
      other_user = create(:user)
      
      token = Token.update_or_create_with_twitter_omniauth(other_user.id, mock_hash)
      expect(token).to be_a Token
      # After the call - object
      # provder method
      expect(token.provider).to eq(provider)
      expect(Token.provider).to eq(provider)

      # provder method

      expect(Token.update_or_create_with_twitter_omniauth(other_user.id, mock_hash)).to be_a Token
      expect(Token.update_or_create_with_other_omniauth(other_user.id, mock_hash)).to be_a Token

    end
  end
end
