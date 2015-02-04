class ChangeUrlAndHtmlColumn < ActiveRecord::Migration
  def self.up
    change_column :shouts, :url, :text
    change_column :shouts, :url_html, :text
  end
 
  def self.down
    change_column :shouts, :url, :string
    change_column :shouts, :url_html, :string
  end
end