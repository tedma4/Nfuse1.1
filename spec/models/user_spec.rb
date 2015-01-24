require 'spec_helper'

context '#basic user' do
  let(:user) {
    FactoryGirl.create(:user, first_name: 'First', last_name: 'Last')
  }

  let(:invalid_user) {
    FactoryGirl.build(:user, first_name: nil, email: nil)
  }

  describe User do

    it '#has a first name and last name # as fullname' do
      expect(user.full_name).to eq 'First Last'
    end

    it '#needs name and email' do
      invalid_user.valid?
      expect(invalid_user.errors[:first_name]).to include("can't be blank")
      expect(invalid_user.errors[:email]).to include("can't be blank")
    end

    it '#not need a password but if so must be 6 chars' do
      user.valid?
      expect(user.errors[:password]).to be_blank
      user.password = 'one'
      user.valid?
      expect(user.errors[:password]).not_to be_blank
    end

    context '#Email' do

      it '#maintains validity' do
        user = FactoryGirl.build(:user, email: 'TestUserEmail@gmail')
        user.valid?
        expect(user.errors[:email]).not_to be_blank
      end

      it '#should not allow duplicate emails' do
        user1 = FactoryGirl.create(:user, email: 'TestUserEmail@gmail.com')
        user2 = FactoryGirl.build(:user,
                                  first_name: 'User 2',
                                  last_name: 'Last', 
                                  email: 'TestUserEmail@gmail.com')
        user2.valid?
        expect(user2).not_to be_valid
        expect(user2.errors[:email]).not_to be_blank
      end

      it 'all emails should be saved as downcase' do
        user = FactoryGirl.create(:user, email: 'TestUserEmail@gmail.com')
        expect(user.email).to eq('testuseremail@gmail.com')
      end
    end

    context '#Status Options' do
      
      # Moved methods to UserOptions module
      it 'maintain original method connection and naming' do
        user = FactoryGirl.build(:user)
        [:rel_stat, :int_in, :look, :gender_txt, :full_name].each do |_method|
          expect(user).to respond_to(_method)
        end
      end

    end
  end
end