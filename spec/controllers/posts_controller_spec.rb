require 'spec_helper'

describe PostsController, type: :controller do
  describe 'POST *create action' do

    context 'logged in' do
    end

    context 'NOT logged in' do
      xit 'should be redirected' do
          login create(:user)
          post 'create'
          # expect(response).not_to be_success
          expect(assigns(:user)).to be_a User
      end
    end

  end 
end

describe SharesController, type: :controller do
  describe 'POST *create action' do

    context 'logged in' do
    end

    context 'NOT logged in' do
      xit 'should be redirected' do
          login create(:user)
          post 'twitter'
          # expect(response).not_to be_success
          expect(assigns(:user)).to be_a User
      end
    end

  end 
end