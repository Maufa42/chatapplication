class Room < ApplicationRecord
  validates_uniqueness_of :name

<<<<<<< HEAD
<<<<<<< HEAD

  scope :public_rooms, -> {where(private: false)}


  has_many :messages
  has_many :participants, dependent: :destroy
  after_create_commit {broadcast_if_public}


  def broadcast_if_public
    broadcast_append_to "rooms" unless self.private
  end

  def self.create_private_room(users,room_name)
    single_room = Room.create(name: room_name, private: true)

    users.each do |user|
      Participant.create(user_id: user.id,room_id: single_room.id)
    end
    single_room
  end

=======
  scope :public_rooms,->{where(private: false)}
  after_create_commit {broadcast_append_to "rooms"}
  has_many :messages
  
>>>>>>> main
=======
  
  scope :public_rooms, -> {where(private: false)}
>>>>>>> parent of 0474c70... ➕  Added Stimulas Controller
end
