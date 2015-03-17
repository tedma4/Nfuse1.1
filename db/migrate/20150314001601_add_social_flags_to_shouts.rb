class AddSocialFlagsToShouts < ActiveRecord::Migration
  def change
    add_column :nfuse_pages, :social_key, :string
    add_column :nfuse_pages, :social_id, :string
    add_column :nfuse_pages, :url, :text
    add_column :nfuse_pages, :nfuse_id, :integer

    add_index  :nfuse_pages, :social_id, unique: true
    add_index  :nfuse_pages, :nfuse_id, unique: true
  end
end