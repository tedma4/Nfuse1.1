require 'spec_helper'

describe RelationshipsController, type: :controller do
  let(:user) {create(:user)}
  let(:related_user) {create(:user)}
  before(:each) do
    user.save
    related_user.save
    login create(:user)
  end

  describe "POST 'create'" do
    it "returns http success" do
      post 'create', {relationship: {followed_id: related_user.id}}
      expect(response.status).to eq 302
    end
    it 'should increase the users relationship count' do
      expect{post 'create', {relationship: {followed_id: related_user.id}}}.to change(current_user.relationships, :count).by(1)
    end
  end

  describe "GET 'destroy'" do
    before {post 'create', {relationship: {followed_id: related_user.id}}}
    it "returns http success" do
      delete 'destroy', {id: Relationship.last.id}
      expect(response.status).to eq 302
    end
    it 'should decrease the users relationship count' do
      expect{delete 'destroy', {id: Relationship.last.id}}.to change(current_user.relationships, :count).by(-1)
    end
  end

end
