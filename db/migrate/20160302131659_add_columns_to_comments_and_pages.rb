class AddColumnsToCommentsAndPages < ActiveRecord::Migration
  def change
  	add_column :pages, :page_category, :string
  	add_column :comments, :hashtag, :string
  	add_column :comments, :tagged_user, :string
  end
end
