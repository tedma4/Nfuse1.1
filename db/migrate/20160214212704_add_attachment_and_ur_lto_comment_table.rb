class AddAttachmentAndUrLtoCommentTable < ActiveRecord::Migration
  def change
  	add_attachment :comments, :image_upload
  	add_column :comments, :url, :text
  	add_column :comments, :url_html, :text
  end
end
