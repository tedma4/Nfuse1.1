class ConversationsController < ApplicationController 
  #This ensures that a user must be logged in to send a chat message
  before_action :signed_in_user
  respond_to :json, :js, :html
  layout false

  def create
    #binding.pry
    if Conversation.between(params[:sender_id],params[:recipient_id]).present?
      @conversation = Conversation.between(params[:sender_id],params[:recipient_id]).first
    else
      @conversation = Conversation.create!(conversation_params)
    end
    render json: { conversation_id: @conversation.id }
  end
 
  def show
    #shows the chatbox
    #user = User.find(params[:id])
    @conversation = Conversation.find(params[:id])
    @reciever = interlocutor(@conversation)
    @messages = @conversation.messages
    @message = Message.new
  end
 
  private
  def conversation_params
    #the parameters used when a conversation is created
    params.permit(:sender_id, :recipient_id)
  end
 
  def interlocutor(conversation)
    #ensures a conversation exists or creates a new one
    current_user == conversation.recipient ? conversation.sender : conversation.recipient
  end
end
