class AddAttachmentToPics < ActiveRecord::Migration
  def change
	 	create_table :pics do |t|
	 		t.string :image_file_name
	 		t.string :image_content_type
	 		t.integer :image_file_size
	 		t.datetime :image_updated_at
	    t.string :caption
	    t.text :description
	    t.integer :user_id
	    
	    t.timestamps
	 	end
	  add_index :pics, :user_id
  end
end
