class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_status

  def index
    @room = Room.new
    @rooms = Room.public_rooms;
    @users = User.all_except(current_user).joins(:messages).order(updated_at: :desc).uniq;
    render 'index'

  end
  
  
  def show
    @room = Room.new
    @rooms = Room.public_rooms;
    @users = User.all_except(current_user).joins(:messages).order(updated_at: :desc).uniq;
    # User.joins(:messages).order(updated_at: :desc)
    @single_room = Room.find(params[:id]);
    @message = Message.new
    @messages = @single_room.messages.order(created_at: :asc)

    render 'index'
  end

  def create
   @room = Room.create(room_params) 
  end

  private

  def room_params
    params.require(:room).permit(:name)
  end
  
  def set_status
    current_user.update!(status: User.statuses[:online]) if current_user
  end

end
