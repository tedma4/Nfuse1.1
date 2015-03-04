class CreateNfusePages < ActiveRecord::Migration
  def change
    create_table :nfuse_pages do |t|
      t.integer :user_id
      t.integer :shout_id
      t.timestamps
    end
  end
end
