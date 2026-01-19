class RoomsController < ApplicationController
  before_action :logged_in_user

  def index
    @rooms = current_user.rooms
  end

  def show
    @room = Room.find(params[:id])
    @messages = @room.messages
    @message = Message.new
  end

  def create
    @room = Room.between(current_user, User.find(params[:user_id]))
    redirect_to @room
  end
end