class AddLinkAndOthersToShouths < ActiveRecord::Migration
  def change
  	add_column :shouts, :title, :string
  	add_column :shouts, :link, :string
  	add_column :shouts, :uid, :string
  	add_column :shouts, :author, :string
  	add_column :shouts, :duration, :string
  	add_index :shouts, :uid, unique: true
  end
end
