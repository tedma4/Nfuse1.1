class AddViewCountToPagesTable < ActiveRecord::Migration
  def change
  	add_column :pages, :view_count, :integer
  end
end
