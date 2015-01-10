class RemoveColumnsFromComment < ActiveRecord::Migration
  def change
  	remove_column :comments, :shout_id
  	remove_index( :comments, :name => 'index_comments_on_user_id' )
  	add_column :comments, :commentable_id, :integer
  	add_column :comments, :commentable_type, :string
  	add_index :comments, [:commentable_id, :commentable_type]
  end
end
