class ChangeThingNameColumnInPagesTable < ActiveRecord::Migration
  def change
  	rename_column :pages, :thing_name, :full_name  	
  end
end
