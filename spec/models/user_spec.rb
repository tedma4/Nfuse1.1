require 'spec_helper'

context '#basic user' do

  let(:user) { build(:user, first_name: 'First', last_name: 'Last', email: 'TestUserEmail@gmail.com') }
  let(:invalid_user) { build(:user, first_name: nil, email: nil)}

  describe User do

    context '#callbacks (before_create)' do
      it '#downcase_email' do
        expect(user).to receive(:downcase_email)
        user.save
      end

      it '#create_remember_token' do
        expect(user).to receive(:create_remember_token)
        user.save
      end
    end

    context '#Base attributes' do

      before(:each) do
        user.valid?
      end

      it '#has a first name and last name # as fullname' do
        expect(user.full_name).to eq 'First Last'
      end

      it '#needs name and email' do
        invalid_user.valid?
        expect(invalid_user.errors[:first_name]).to include("can't be blank")
        expect(invalid_user.errors[:email]).to include("can't be blank")
      end

      it '#not need a password but if so must be 6 chars' do
        expect(user.errors[:password]).to be_blank
        user.password = 'one'
        user.valid?
        expect(user.errors[:password]).not_to be_blank
      end
    end

    context '#Email' do

      it '#maintains validity' do
        _user = build(:user, email: 'TestUserEmail@gmail')
        _user.valid?
        expect(_user.errors[:email]).not_to be_blank
      end

      it '#should not allow duplicate emails' do
        user1 = create(:user, email: 'TestUserEmail@gmail.com')
        user2 = build(:user,
                                  first_name: 'User 2',
                                  last_name: 'Last', 
                                  email: 'TestUserEmail@gmail.com')
        user2.valid?
        expect(user2).not_to be_valid
        expect(user2.errors[:email]).not_to be_blank
      end

      it 'all emails should be saved as downcase' do
        user = create(:user, email: 'TestUserEmail@gmail.com')
        expect(user.email).to eq('testuseremail@gmail.com')
      end
    end

    context '#Status Options' do
      # Moved methods to UserOptions module
      it 'maintain original method connection and naming' do
        user = build(:user)
        [:rel_stat, :int_in, :look, :gender_txt, :full_name].each do |_method|
          expect(user).to respond_to(_method)
        end
      end
    end

    describe  '#Passwords & tokens' do

      it '#responds to password methods' do
        user.save
        expect(user).not_to be_new_record
        expect(user.new_remember_token).to be_a(String)
        expect(user.remember_token).to be_a(String)
        expect(user.persisted?).to be_truthy
      end

      context 'Authentication internals' do

        it '#digest' do
          # @user = build(:user)
          expect(SecureRandom).to receive(:urlsafe_base64)
          expect(Digest::SHA1).to receive(:hexdigest)
          token = user.new_remember_token
          user.digest(token)
        end

      end
    end

  end
end