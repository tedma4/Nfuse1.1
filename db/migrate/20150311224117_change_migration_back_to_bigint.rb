class ChangeMigrationBackToBigint < ActiveRecord::Migration
  def change
  	change_column :votes, :votable_id, :string
  end
end
