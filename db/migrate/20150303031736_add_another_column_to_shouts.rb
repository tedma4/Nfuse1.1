class AddAnotherColumnToShouts < ActiveRecord::Migration
  def change
    add_column :shouts, :nfuse_page_id, :integer
  end
end
