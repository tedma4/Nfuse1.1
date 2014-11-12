class RemoveUsernameIndex < ActiveRecord::Migration
  def change
  	remove_index(:identities, column: :user_name)
  end
end
