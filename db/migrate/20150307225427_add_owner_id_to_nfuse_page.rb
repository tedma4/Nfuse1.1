class AddOwnerIdToNfusePage < ActiveRecord::Migration
  def change
  	add_column :nfuse_pages, :owner_id, :string
  	add_column :nfuse_pages, :social_flag, :string
  	change_column :nfuse_pages, :shout_id, :string
  end
end
