class AddExclusiveTypeToShouts < ActiveRecord::Migration
  def change
    add_column :shouts, :is_exclusive, :boolean, default: false 
  end
end
