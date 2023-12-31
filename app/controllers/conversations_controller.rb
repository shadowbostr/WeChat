class ConversationsController < ApplicationController
  def create_conversation
    @selected_user = User.find(params[:user_id])
    @conversation = current_user.conversations.find_by(id: @selected_user.conversations.pluck(:id))

    unless @conversation
      @conversation = Conversation.create
      @conversation.users << current_user
      @conversation.users << @selected_user
    end

    redirect_to conversation_path(@conversation)
end


  def show
    @conversation = Conversation.find(params[:id])
    @messages = @conversation.messages.includes(:user)
    @selected_user = @conversation.users.where.not(id: current_user.id).first

  end

  def mark_as_read
    @conversation = conversation_params[:id]
    @conversation.new_message_presence = false
    @conversation.save
  end

  private

  def conversation_params
    params.require(:conversation).permit(:id,:user_id)
  end

end
