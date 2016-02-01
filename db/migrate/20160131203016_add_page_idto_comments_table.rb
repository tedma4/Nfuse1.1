class AddPageIdtoCommentsTable < ActiveRecord::Migration
  def change
  	add_column :comments, :page_id, :integer
  end
end
