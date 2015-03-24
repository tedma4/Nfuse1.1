class ContactsController < ApplicationController
  #This controller is the "Contact Us" emailer
  def new
    #this starts the new contact email process
    @contact = Contact.new
  end

  def create
    #thi creates a new email and sends it
    @contact = Contact.new(params[:contact])
    @contact.request = request
    if @contact.deliver
    else
      flash.now[:error] = 'Cannot send message.'
      render :new
    end
  end
end