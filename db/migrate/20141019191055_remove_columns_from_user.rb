class RemoveColumnsFromUser < ActiveRecord::Migration
  def change
  	remove_column :users, :first_name
  	remove_column :users, :last_name
  	remove_column :users, :password_digest
  	remove_column :users, :email
  end
end
