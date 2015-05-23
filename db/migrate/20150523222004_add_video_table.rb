class AddVideoTable < ActiveRecord::Migration
  def change
	 	create_table :videos do |t|
	 		t.string :full_video_file_name
	 		t.string :full_video_content_type
	 		t.integer :full_video_file_size
	 		t.datetime :full_video_updated_at
	    t.string :caption
	    t.text :description
	    t.integer :user_id

	 		t.timestamps
	 	end
	  add_index :videos, :user_id

	  add_attachment :shouts, :video
	  add_column :shouts, :is_full_video, :boolean, default: 0	  
  end
end
