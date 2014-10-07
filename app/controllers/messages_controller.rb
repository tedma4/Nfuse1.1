class MessagesController < ApplicationController
  #This ensures that a user must be logged in to send a chat message
  before_action :signed_in_user
  
	def create
    #Creates a new message b/w the currently logged in user and the user they are in a conversation with
    @conversation = Conversation.find(params[:conversation_id])
    @message = @conversation.messages.build(message_params)
    @message.user_id = current_user.id
    @message.save!
 
    @path = conversation_path(@conversation)
  end
 
  private
 
  def message_params
    params.require(:message).permit(:body)
  end
end