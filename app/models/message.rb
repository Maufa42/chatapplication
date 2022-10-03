class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room
 

  after_create_commit { broadcast_append_to self.room }
  
  before_create :confirm_participants

  def confirm_participants
    return unless room.private
      is_participant = Participant.where(user_id: self.user.id, room_id: self.room.id).first
      throw :abort unless is_participant
  end

=======
  
end
