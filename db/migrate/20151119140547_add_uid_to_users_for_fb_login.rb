class AddUidToUsersForFbLogin < ActiveRecord::Migration
  def change
    add_column :users, :uid, :string
    add_column :users, :providers, :string
  end
end
