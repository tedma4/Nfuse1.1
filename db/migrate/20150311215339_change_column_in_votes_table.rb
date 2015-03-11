class ChangeColumnInVotesTable < ActiveRecord::Migration
  def change
  	add_column :comments, :owner_id, :integer
  	change_column :votes, :votable_id, :string
  end
end
