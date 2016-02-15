class OurAwesomeMailer < ActionMailer::Base
  default :from => "notifications@example.com"
  @@us = ['tedma4@yahoo.com', 'ower@cerebralhq.com']
 
  def forum_post(user, comment, page = nil)
    @user = user
    @comment = comment
    @page = page
    mail(:to => @@us, :subject => "Welcome to My Awesome Site")
  end

	def experror(e)
		@err = e
		mail(:to => @@us, :subject => "#{e.message}")
	end
end