class ShoutTypeFlag < ActiveRecord::Migration

  def change
    add_column :shouts, :is_video, :boolean, default: 0
  end

end
