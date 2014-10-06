class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
    	t.integer :user_id
      t.index :user_id

      t.timestamps
    end
  end
end
