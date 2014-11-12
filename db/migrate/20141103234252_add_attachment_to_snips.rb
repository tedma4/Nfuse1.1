class AddAttachmentToSnips < ActiveRecord::Migration
  def change
	 	create_table :snips do |t|
	 		t.string :video_file_name
	 		t.string :video_content_type
	 		t.integer :video_file_size
	 		t.datetime :video_updated_at
	    t.string :caption
	    t.text :description
	    t.integer :user_id

	 		t.timestamps
	 	end
	  add_index :snips, :user_id
  end
end
