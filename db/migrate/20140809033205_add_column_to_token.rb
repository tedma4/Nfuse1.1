class AddColumnToToken < ActiveRecord::Migration
  def change
  	add_column :tokens, :provider, :string
  	add_column :tokens, :uid, :string
  	add_column :tokens, :access_token, :string
  	add_column :tokens, :access_token_secret, :string
  	add_column :tokens, :user_id, :integer
  	add_index :tokens, :user_id
  end
end
