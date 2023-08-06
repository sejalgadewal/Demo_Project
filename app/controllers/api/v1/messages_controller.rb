class Api::V1::MessagesController < ApplicationController
  def create
    @current_user = current_user
    @message = @current_user.messages.create(content: msg_params[:content], room_id: params[:room_id])

    if @message.persisted?
      render json: { message: 'Message sent successfully.' }
    else
      render json: { errors: @message.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def msg_params
    params.require(:message).permit(:content)
  end
end
