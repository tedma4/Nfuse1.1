# encoding: UTF-8
class ActiveRecord::Base

	def self.has_destroyable_file(*attachments)
		attachments.each do |attachment|
			attr_accessor :"#{attachment}_delete"
			before_save do
				self.send(attachment).clear if self.send(:"#{attachment}_delete") == "1"
			end
		end
	end
end