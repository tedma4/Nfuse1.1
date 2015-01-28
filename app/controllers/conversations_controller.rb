class ConversationsController < ApplicationController 
  #This ensures that a user must be logged in to send a chat message
  before_action :signed_in_user
  respond_to :json, :js, :html
  layout false

  def create
    @conversation = Conversation.find_or_start_convo(params)
    render json: { conversation_id: @conversation.id }
  end

  def show
    begin
      @conversation = current_user.conversations.find(params[:id])
      @reciever = interlocutor(@conversation)
      @messages = @conversation.messages
      @message = Message.new  
     rescue ActiveRecord::RecordNotFound => e
        redirect_to root_url , notice: 'Not your conversation'
     end 
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
