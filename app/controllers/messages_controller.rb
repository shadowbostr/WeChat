class MessagesController < ApplicationController

  def create
    @conversation = params[:conversation_id]
    @message = Message.new(message_params)
    @message.user = current_user
    respond_to do |format|
      if @message.save
        format.js
      else
        format.html { redirect_to conversation_path(@conversation)  }
        format.js

      end
    end
  end


  def destroy
    @message = Message.find(params[:id])
    authorize! :destroy, @message
    @conversation = @message.conversation

    respond_to do |format|
      if @message.destroy
        format.html { redirect_to conversation_path(@conversation) }
        format.js
    else
      format.js
      end
    end
  end


  private

  def message_params
    params.require(:message).permit(:content, :user_id, :conversation_id)
  end

end
