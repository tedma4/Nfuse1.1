class Contact < MailForm::Base
  attribute :full_name,      :validate => true
  attribute :email,     :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :message
  attribute :nickname,  :captcha  => true

  # Declare the e-mail headers. It accepts anything the mail method in ActionMailer accepts.
  def headers
    {
      :subject => "My Contact Form",
      :to => "ower@cerebralhq.com",
      :from => %("#{full_name}" <#{email}>)
    }
  end
end