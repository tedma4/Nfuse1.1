class ChangeBooleanOptionFromFalseToZero < ActiveRecord::Migration
  def change
   change_column :shouts, :is_video, :boolean, :default => 0
   change_column :shouts, :is_link, :boolean, :default => 0
   change_column :shouts, :is_pic, :boolean, :default => 0
   change_column :shouts, :has_content, :boolean, :default => 0
  end
end
