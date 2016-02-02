class AddPageIdtoCommentsTable < ActiveRecord::Migration
  def change
  	add_column :comments, :page_id, :integer
  	add_column :comments, :comment_id, :integer
  end
end
