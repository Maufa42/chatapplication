class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room
  
  has_many_attached :attachments, dependent: :destroy
  
  after_create_commit do
    update_parent_room 
    broadcast_append_to room 
  end
  
  def image?(file)
    file.to_s.include?(".gif") or file.to_s.include?(".png") or file.to_s.include?(".jpg")
  end

  def chat_attachment(index)
    target = attachments[index]
    
    # binding.pry

    return unless attachments.attached?

    if target.image?
      target.variant(resize_to_limit: [150, 150]).processed
    elsif target.video?
      target.variant(resize_to_limit: [150, 150]).processed
    end
  end
  
  
  before_create :confirm_participants

  def confirm_participants
    return unless room.private
      is_participant = Participant.where(user_id: self.user.id, room_id: self.room.id).first
      throw :abort unless is_participant
  end

  def update_parent_room
    room.update(last_message_at: Time.now)
  end

end
