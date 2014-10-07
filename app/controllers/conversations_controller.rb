class ConversationsController < ApplicationController 
  #This ensures that a user must be logged in to send a chat message
  before_action :signed_in_user

  layout false

  def create
    #Creates a new conversation b/w the currently logged in user and another user
    if Conversation.between(params[:sender_id],params[:recipient_id]).present?
      @conversation = Conversation.between(params[:sender_id],params[:recipient_id]).first
    else
      @conversation = Conversation.create!(conversation_params)
    end
 
    render json: { conversation_id: @conversation.id }
  end
 
  def show
    #shows the chatbox
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
