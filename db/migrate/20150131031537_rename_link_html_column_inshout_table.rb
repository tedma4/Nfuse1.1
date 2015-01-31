class RenameLinkHtmlColumnInshoutTable < ActiveRecord::Migration
  def change
  	rename_column :shouts, :link_body, :url_html
  	add_column :shouts, :url, :string
  end
end
