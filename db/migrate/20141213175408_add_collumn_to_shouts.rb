class AddCollumnToShouts < ActiveRecord::Migration
  def change
    add_column :shouts, :is_link, :boolean, default: :false
  end
end
