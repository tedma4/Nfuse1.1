require 'spec_helper'

describe UsersController, type: :controller do

  describe "GET 'index'" do
    let(:user)  { create(:user) }

    before(:each) do
      login user
    end

    after(:each) do
      log_out
    end

    context 'logged in' do
      it "returns http success" do
        get 'index'
        expect(assigns(:users)).to be_a ActiveRecord::Relation

        num = (rand(10)+1)
        num.times { create(:user) }

        expect(assigns[:users]).not_to include(user)
        expect(assigns[:users].count).to eq(num)
        expect(response).to be_success
      end
    end

    context '#logged out' do
      it 'redirects to signin page' do
        log_out
        get 'index'
        expect(response).not_to be_success
        # expect(response).to redirect_to root_path
        expect(response).to redirect_to signin_path
      end
    end

  end

  describe '#show' do

    let(:user)  { create(:user) }

    before(:each) do
      login user
    end

    after(:each) do
      log_out
    end


    context 'logged in' do
      it 'returns user object from param[:id]' do
        get 'show', id: user.id
        expect(assigns[:user]).to eq user
      end

      it 'shows other user NOT logged in user' do
        other_user = create(:user)
        get 'show', id: other_user.id
        expect(assigns[:user]).to eq other_user
      end

      it 'maintains session id as logged_in not other_user' do
        # user = login user from before(:callback)
        other_user = create(:user)
        get 'show', id: other_user.id
        expect(User.find(request.session[:user_id])).to eq user
        expect(assigns[:current_user]).to eq user
      end
    end

    context 'not logged in' do
      before { request.host = 'nfuse.com' }
      it 'issues redirect' do
        log_out
        other_user = create(:user)
        get 'show', id: other_user.id
        expect(response).not_to be_success
        expect(response).to redirect_to signin_url
      end
    end
  end

  describe '#settings' do
    let(:user) { create :user }
    before {login user}
    it 'should assign user variable as blank new user' do
      get 'settings'
      expect(assigns[:display_network]).to be_falsey
    end
  end

  describe '#new' do
    let(:user) { create :user }
    before {login user}
    it 'should assign user variable as blank new user' do
      get 'new'
      expect(assigns[:user]).not_to be_nil
    end
  end

  describe '#feed' do
    let(:shout) { create :shout }
    let(:user) { create :user, shouts: [shout] }

    it 'maintains all old instance vars' do
      login user
      get 'feed', id: user.id
      expect(assigns[:timeline]).to be_a Array
      expect(assigns[:providers]).to be_a Providers
      expect(assigns[:unauthed_accounts]).to be_a Array
    end
  end

  describe 'POST #create' do

    before  do
      @user_params = {user: {
          email: 'user@example.com',
          first_name: 'boo',
          last_name: 'radley',
          user_name: 'uname',
          password: 'Qwerty1!',
          password_confirmation: 'Qwerty1!',
          phone_number: '123-456-7788',
          intro: 4081
      }}
    end

    it 'should successfully create a user with good params' do
      expect{post 'create', @user_params}.to change(User, :count).by(1)
    end
    it 'should set the sessions[:user_id], signing in the user' do
      post 'create', @user_params
      expect(session[:user_id]).not_to be_nil
      expect(session[:user_id]).to eq User.last.id
    end
    it 'should not create a user with bad params' do
      bad_params = {user: {email: 'boo@radley.com'}}
      expect{post 'create', bad_params}.to change(User, :count).by(0)
    end
  end

  describe 'PUT #update' do
    let(:user) { create :user }
    before do
      login user
    end
    it 'should update the users attributes with good input' do
      expect do
        put 'update', {id: user.id, user: {email: 'new@email.com'}}
        user.reload
      end.to change(user, :email)
    end
    it 'should redirect to feed_user_path on successful update' do
      put 'update', {id: user.id, user: {email: 'new@email.com'}}
      expect(response).to redirect_to feed_user_path(user)
    end
    it 'should fail updating with bad input' do
      expect do
        put 'update', {id: user.id, user: {email: 'b.x'}}
        user.reload
      end.not_to change(user, :email)
    end
    it "should render 'new' on failed update" do
      put 'update', {id: user.id, user: {email: 'b.x'}}
      expect(response).to render_template 'edit'
    end
  end

  describe 'delete #destroy' do
    describe 'non admins cant delete' do
      let(:user) { create :user }
      before do
        request.host = 'nfuse.com'
        login user
      end
      it 'should not lower the user count' do
        expect{delete 'destroy', {id: user.id}}.to change(User, :count).by(0)
      end
      it 'should redirect to home page' do
        delete 'destroy', {id: user.id}
        expect(response).to redirect_to root_url
      end
    end
    describe 'can delete sucessfully as admin' do
      let(:user) { create :user, admin: true }
      before do
        request.host = 'nfuse.com'
        login user
      end
      it 'should lower the user count' do
        expect{delete 'destroy', {id: user.id}}.to change(User, :count).by(-1)
      end
      it 'should redirect to users index' do
        delete 'destroy', {id: user.id}
        expect(response).to redirect_to users_url
      end
    end
  end

  # describe '#indexed' do
  #   let(:user) { create :user, admin: true }
  #   before do
  #     request.host = 'nfuse.com'
  #     login user
  #   end
  #   it 'should render users/settings if user has no providers' do
  #     get 'indexed'
  #     expect(response).to render_template('users/settings')
  #   end
  #   describe 'If the user has a provider' do
  #     before do
  #       @provider = create(:provider)
  #       Providers.for(user) << @provider
  #     end
  #     it 'should render indexed when user has a provider' do
  #       get 'indexed'
  #       expect(response).to render_template('users/indexed')
  #     end
  #   end

  describe '#feed_content' do
    let(:user) { create :user }
    before do
      login user
    end

  end
end
