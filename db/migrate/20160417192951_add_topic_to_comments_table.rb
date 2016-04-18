class AddTopicToCommentsTable < ActiveRecord::Migration
  def change
  	add_column :comments, :topic, :string
  end
end
