class ChangeColumnTypeInVotesTable < ActiveRecord::Migration
  def self.up
    change_column :votes, :votable_id, :bigint
  end
 
  def self.down
    change_column :votes, :votable_id, :integer
  end
end
