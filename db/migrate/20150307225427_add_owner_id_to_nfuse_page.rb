class AddOwnerIdToNfusePage < ActiveRecord::Migration
  def change
  	add_column :nfuse_pages, :owner_id, :bigint
  	add_column :nfuse_pages, :social_flag, :string
  	change_column :nfuse_pages, :shout_id, :bigint
  end
end
