require 'spec_helper'

context '#basic user' do

  let(:user) { build(:user) }
  let(:invalid_user) { build(:user, first_name: nil, email: nil)}
  let(:multiple_users) { 5.times do create(:user); end }

  describe User do

    describe 'Associations' do
      it 'has_many followers'
      it 'follows many others'
    end

    describe '#custom queries' do

      it '#search' do
        user = create(:user)
        expect( User.search(user.first_name) ).to be_a ActiveRecord::Relation
        expect( User.search(user.first_name).first ).to eq user
      end

      it '#all_except' do
        multiple_users
        user.save
        expect(User.all_except(user)).not_to include(user)
      end

      xit '#total_followers' do
          followers=double('followers')
          expect(followers).to receive(:count).and_return(user_num)
          allow(this_user).to receive(:followers).and_return(followers)
          expect(this_user.total_followers).to eq(user_num)
      end
    end

    describe 'Following / Followers' do 
      
      before(:each) do
        user.save
      end

      it 'is able to find followers' do
        expect { 
          @relationship = create(:relationship, follower: user)
        }.to change(Relationship, :count)
        expect(@relationship).to be_a Relationship
      end

      describe 'follow multiple people' do 
        let(:user_num) {rand(10)+1} # to make sure its not 0
        let(:this_user) { create(:user) }
        let(:multiple_follows) { user_num.times do this_user.follow! create(:user); end }

        it '#total_followers' do
          followers=double('followers')
          expect(followers).to receive(:count).and_return(user_num)
          allow(this_user).to receive(:followers).and_return(followers)
          expect(this_user.total_followers).to eq(user_num)
        end


        it 'followed_users and relationships count are the same' do
          expect { multiple_follows }.to change( this_user.followed_users, :count).by( user_num )
        end

        it 'checks reverse follow' do
          multiple_follows
          random_user = this_user.followed_users.sample
          expect(random_user.followers).to include(this_user)
        end
      end

      it '#following?' do
        relationship = create(:relationship, follower: user)
        other_user = relationship.followed

        expect( user.following?(other_user) ).to be true
        expect( user.following? create(:user) ).not_to be_truthy
      end

      it '#follow!' do
        expect {
          user.follow!(create(:user))
        }.to change(Relationship, :count).by(1)
      end

      it '#unfollow' do
        relationship = create(:relationship)
        user = relationship.followed
        other_user = relationship.follower

        expect {
          other_user.unfollow!(user)
        }.to change(Relationship, :count).by(-1)
      end

      it 'changes followed_users count' do
        expect { 
          create(:relationship, follower: user)
        }.to change(user.followed_users, :count)
      end
    end

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
        expect(user.full_name).to eq "#{user.first_name} #{user.last_name}"
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
          expect(SecureRandom).to receive(:urlsafe_base64)
          expect(Digest::SHA1).to receive(:hexdigest)
          token = user.new_remember_token
          user.digest(token)
        end

      end
    end

  end
end