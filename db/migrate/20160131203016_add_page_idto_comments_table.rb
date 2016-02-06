class AddPageIdtoCommentsTable < ActiveRecord::Migration
  def change
  	add_column :comments, :page_id, :integer
  	add_column :comments, :comment_id, :integer
  	add_column :comments, :ancestry, :string
  	add_index :comments, :ancestry
  end
end
