# encoding: UTF-8
class ActiveRecord::Base
	# Class method to add destroyable paperclip attachments.
	#
	# Example:
	# has_attached_file :image
	# has_destroyable_file :image
	# attr_accessible :image_delete
	#
	# Adds `image_delete`, `image_delete=` methods. Before_save if `image_delete` is
	# set to "1", the `image` attachment gets deleted.
	#
	# Example html in form:
	# <%= f.check_box :image_delete %>
	# <%= f.label :image_delete, 'Delete image' %>
	def self.has_destroyable_file(*attachments)
		attachments.each do |attachment|
			attr_accessor :"#{attachment}_delete"
			before_save do
				self.send(attachment).clear if self.send(:"#{attachment}_delete") == "1"
			end
		end
	end
end