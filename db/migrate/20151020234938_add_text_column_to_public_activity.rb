class AddTextColumnToPublicActivity < ActiveRecord::Migration
  def change
    add_column :activities, :user_recipients, :text
  end
end
