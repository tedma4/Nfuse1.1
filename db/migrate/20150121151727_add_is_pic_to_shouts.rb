class AddIsPicToShouts < ActiveRecord::Migration
  def change
    add_column :shouts, :is_pic, :boolean, default: :false
  end
end
