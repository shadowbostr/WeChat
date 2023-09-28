class MessagesController < ApplicationController
  def create
    @conversation = params[:conversation_id]
    @message = Message.new(message_params)
    @message.user = current_user
    respond_to do |format|
      if @message.save
        format.html { redirect_to conversation_path(@message.conversation), notice: "message sent." }
        format.js
      else
        format.html { redirect_to conversation_path(@conversation),  status: :unprocessable_entity  }
        format.js

      end
    end
  end

  def destroy
    authorize! :destroy, @message
    @message = Message.find(params[:id])
    @conversation = @message.conversation

    if @message.destroy
      respond_to do |format|
        format.html { redirect_to conversation_path(@conversation) }
        format.js
      end
    else
      format.js
    end
  end


  private

  def message_params
    params.require(:message).permit(:content, :user_id, :conversation_id)
  end

end
