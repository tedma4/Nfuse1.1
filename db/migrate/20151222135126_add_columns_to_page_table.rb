class AddColumnsToPageTable < ActiveRecord::Migration
  def change
    add_column :pages, :thing_name, :string
    add_column :pages, :twitter_handle, :string
    add_column :pages, :youtube_handle, :string
    add_column :pages, :instagram_handle, :string
    add_column :pages, :facebook_handle, :string
    add_column :pages, :pinterest_handle, :string
    add_column :pages, :tumblr_handle, :string
    add_column :pages, :gplus_handle, :string
  end
end
