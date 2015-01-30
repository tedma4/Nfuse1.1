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

    AToken = Struct.new(:x) do 
      def token 
          SecureRandom.hex(20)
      end
      def secret
          SecureRandom.hex(20)
      end
    end

    before(:each) do
      @auth_hash = attributes_for(:token)
      # mock twitter_hash 
      @provider  = ['twitter', 'instagram', 'facebook', 'youtube'].sample
      @mock_hash = {
          'provider' => @provider,
           'uid' => SecureRandom.hex(10),
           'extra' => { 'access_token' =>  AToken.new },
           'credentials' => {'token' => AToken.new.token }
        }
      @other_user = create(:user)
    end

    context 'Token#update_or_create_token' do

      it 'basic OmniAuth Token' do
        token = Token.update_or_create_token(@other_user.id, @mock_hash)
        # Not to be set.
        expect(token.access_token_secret).to be_nil
        expect(token.access_token).not_to be_nil
        expect(token).to be_a Token

      end

      it 'sets twitter methods' do
        token = Token.update_or_create_token(@other_user.id, @mock_hash, 'twitter')
        expect(token.access_token_secret).not_to be_nil
        expect(token.access_token).not_to be_nil
      end

    end

    it 'can find or create token' do
      other_user = create(:user)
      token = Token.update_or_create_with_twitter_omniauth(other_user.id, @mock_hash)
      expect(token).to be_a Token
      expect(token.access_token).not_to be_nil
      # After the call - object
      # provder method ( a private must use send to test.)
      expect(token.send :provider).to eq(@provider)
      expect(Token.send :provider).to eq(@provider)

      # Original Methods still work.
      expect(Token.update_or_create_with_twitter_omniauth(other_user.id, @mock_hash)).to be_a Token
      expect(Token.update_or_create_with_other_omniauth(other_user.id, @mock_hash)).to be_a Token

    end
  end
end
