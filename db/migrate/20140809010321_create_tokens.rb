class CreateTokens < ActiveRecord::Migration
  def change
    create_table :tokens do |t|
      t.string :provider
      t.string :uid
      t.string :access_token
      t.integer :user_id
      t.index :user_id
      t.string :access_token_secret

      t.timestamps
    end
  end
end
