class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
    	t.string :name
    	t.text :description
    	t.attachment :cover
    	t.date :date
	    t.time :time
	    t.string :city
	    t.integer :user_id

      t.timestamps
    end
  end
end
