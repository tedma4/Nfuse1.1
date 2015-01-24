require 'spec_helper'

describe Relationship do

  it 'be associated with User class' do
    relationship = Relationship.new(followed: nil)
    expect(relationship).not_to be_valid
  end

  it 'two new users build a relationship' do
    relationship = build(:relationship)
    expect(relationship).to be_valid
    relationship.save

    expect(Relationship.count).not_to be 0
  end

  it 'demonstrates associations' do
    rel_  = Relationship.reflect_on_association(:followed)
    expect(rel_.macro).to eq(:belongs_to)

    rel_2 = Relationship.reflect_on_association(:follower)
    expect(rel_2.macro).to eq(:belongs_to)
  end

  describe 'user connected to other' do
    
  end

  describe 'Constraints to the Relationships' do
    context 'who can follow who?' do
    end

    context 'blocking?'
  end
end

