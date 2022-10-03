class RoomsController < ApplicationController
  before_action :authenticate_user!

<<<<<<< HEAD

  def index
    @rooms = Room.public_rooms;
    @users = User.all_except(current_user);
<<<<<<< HEAD
=======
  def index
    @room = Room.new
    @rooms = Room.public_rooms;
    @users = User.except_current(current_user);
>>>>>>> main
    render 'index'

  end
  
<<<<<<< HEAD
  
  def show
    @room = Room.new
    @rooms = Room.public_rooms;
    @users = User.all_except(current_user);
    @single_room = Room.find(params[:id]);
=======
  def create
    @room  = Room.create(room_params)
  end
  def show
    @single_room = Room.find(params[:id])

    @room = Room.new
    @rooms = Room.public_rooms;
>>>>>>> main

    @message = Message.new
    @messages = @single_room.messages.order(created_at: :asc)

<<<<<<< HEAD
    render 'index'
  end

  def create
   @room = Room.create(room_params) 
=======
    @users = User.except_current(current_user);

    render 'index'

>>>>>>> main
=======
>>>>>>> parent of 0474c70... ➕  Added Stimulas Controller
  end


end
