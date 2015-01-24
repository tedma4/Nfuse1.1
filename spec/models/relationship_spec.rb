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

end
