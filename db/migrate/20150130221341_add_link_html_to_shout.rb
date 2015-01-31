class AddLinkHtmlToShout < ActiveRecord::Migration
  def change
  	add_column :shouts, :link_body, :string
  end
end
