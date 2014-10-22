class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_digest
      t.integer :user_id
      t.index :user_id
      t.timestamps
    end
  end
end
