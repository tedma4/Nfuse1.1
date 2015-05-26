class ChangeCommentableType < ActiveRecord::Migration
  def change
  	change_column :comments, :commentable_id, :string
  end
end
