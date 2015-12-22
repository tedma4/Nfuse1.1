class AddClassNameToRelationshipsTable < ActiveRecord::Migration
  def change
    add_column :relationships, :follow_type, :string
  end
end
