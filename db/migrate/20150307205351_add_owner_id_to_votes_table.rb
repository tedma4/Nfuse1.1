class AddOwnerIdToVotesTable < ActiveRecord::Migration
  def change
    add_column :votes, :owner_id, :integer
  end
end
