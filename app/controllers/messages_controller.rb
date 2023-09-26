class MessagesController < ApplicationController
  def create
    @message = Message.new(message_params)
    @message.user = current_user
    respond_to do |format|
      if @message.save
        format.html { redirect_to conversation_path(@message.conversation), notice: "message sent." }
      else
        format.html { render "conversations/show", status: :unprocessable_entity  }

      end
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :user_id, :conversation_id)
  end

end
