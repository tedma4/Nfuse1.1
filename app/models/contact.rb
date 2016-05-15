class Contact < MailForm::Base
  attribute :full_name, allow_blank: true#     :validate => true
  attribute :email,     allow_blank: true #:validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :message, presence: true
  attribute :nickname,  :captcha  => true

  # Declare the e-mail headers. It accepts anything the mail method in ActionMailer accepts.
  def headers
    {
      :subject => "My Contact Form",
      :to => "ower@cerebralhq.com",
      :from => %("#{full_name || 'Request'}" <#{email || 'nfuse@request.com'}>)
    }
  end
end