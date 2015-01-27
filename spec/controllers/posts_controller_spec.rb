require 'spec_helper'

describe PostsController, type: :controller do
  describe 'POST *create action' do

    context 'logged in' do
    end

    context 'NOT logged in' do
      xit 'should be redirected' do
          get 'create'
          expect(response).not_to be_success
      end
    end

  end 
end