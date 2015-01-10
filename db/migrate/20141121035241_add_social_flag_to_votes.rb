class AddSocialFlagToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :social_flag, :string
  end
end
