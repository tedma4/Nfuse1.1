class CreateShouts < ActiveRecord::Migration
  def change
    create_table :shouts do |t|
      t.text :content
      t.integer :user_id
      t.attachment :pic
      t.attachment :snip
      t.integer :likes
      t.integer :dislikes
      t.integer :comments
      t.string :permalink
      
      t.timestamps
    end
    add_index :shouts, [:user_id, :created_at]
  	add_index :shouts, :permalink
  end
end
