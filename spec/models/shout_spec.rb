require 'spec_helper'

describe Shout do
  it { is_expected.to belong_to :user }
  it { is_expected.to validate_presence_of(:user_id) }
  it { is_expected.to have_many(:comments) }
end
