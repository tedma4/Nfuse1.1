require 'spec_helper'

context '#basic user' do
  let(:user) {
    FactoryGirl.build(:user, first_name: 'First', last_name: 'Last')
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
  end
end