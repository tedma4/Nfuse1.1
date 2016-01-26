class AddOwnerTypeToVotesTable < ActiveRecord::Migration
  def change
  	add_column :votes, :owner_type, :string
  end
end
