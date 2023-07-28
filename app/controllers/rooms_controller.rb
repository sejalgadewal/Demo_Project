class RoomsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @room=Room.new
    @current_user= current_user
    @rooms = Room.public_rooms
    @users= User.all_except(@current_user)
  end
  
  def create
    @room = Room.create(name: params["room"]["name"])
    authorize! :manage, @room
  end

  def show
    @single_room = Room.find(params[:id])
    @room = Room.new
    @rooms = Room.public_rooms
    @message = Message.new
    @messages = @single_room.messages.order(created_at: :asc)
    @current_user = current_user
    @users = User.all_except(@current_user)
   
    render "index"
  end
end
