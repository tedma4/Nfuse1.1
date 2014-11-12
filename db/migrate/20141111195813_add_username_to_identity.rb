class AddUsernameToIdentity < ActiveRecord::Migration
  def change
    add_column :identities, :user_name, :string
    add_index :identities, :user_name, :unique => true
  end
end
