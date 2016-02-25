class AddTitleAndDescriptionToPageTable < ActiveRecord::Migration
  def change
  	add_column :pages, :metatag_title, :string
  	add_column :pages, :description, :text
  	add_attachment :pages, :page_avatar
  	add_index :pages, 	:page_name
  end
end
