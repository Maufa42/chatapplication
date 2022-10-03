class RoomsController < ApplicationController
  before_action :authenticate_user!


  def index
    @room = Room.new
    @rooms = Room.public_rooms;
    @users = User.all_except(current_user);

  def index
    @room = Room.new
    @rooms = Room.public_rooms;
    @users = User.except_current(current_user);

    render 'index'

  end
  
  
  def show
    @room = Room.new
    @rooms = Room.public_rooms;
    @users = User.all_except(current_user);
    @single_room = Room.find(params[:id]);

  def create
    @room  = Room.create(room_params)
  end
  def show
    @single_room = Room.find(params[:id])

    @room = Room.new
    @rooms = Room.public_rooms;

    @message = Message.new
    @messages = @single_room.messages.order(created_at: :asc)


    render 'index'
  end

  def create
   @room = Room.create(room_params) 

    @users = User.except_current(current_user);

    render 'index'


  end

  private

  def room_params
    params.require(:room).permit(:name)
  end

end
