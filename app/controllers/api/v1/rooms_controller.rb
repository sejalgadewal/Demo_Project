class Api::V1::RoomsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @rooms = Room.public_rooms
    @users = User.all_except(current_user)
    render json: { rooms: @rooms, users: @users }
  end
  
  def create
    @room = Room.create(name: params[:name])
    authorize! :manage, @room

    if @room.save?
      render json: { message: 'Room created successfully.' }
    else
      render json: { errors: @room.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    @single_room = Room.find(params[:id])
    @messages = @single_room.messages.order(created_at: :asc)
    @users = User.all_except(current_user)

    render json: { room: @single_room, messages: @messages, users: @users }
  end
end
