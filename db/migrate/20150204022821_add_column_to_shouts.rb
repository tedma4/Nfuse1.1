class AddColumnToShouts < ActiveRecord::Migration
  def change
    add_column :shouts, :has_content, :boolean, default: 0
  end
end
