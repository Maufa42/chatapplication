# frozen_string_literal: true

class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room

  has_many_attached :attachments, dependent: :destroy

  def image?(file)
    file.to_s.include?('.gif') or file.to_s.include?('.png') or file.to_s.include?('.jpg')
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

  after_create_commit { broadcast_append_to room }

  before_create :confirm_participants

  def confirm_participants
    return unless room.private

    is_participant = Participant.where(user_id: user.id, room_id: room.id).first
    throw :abort unless is_participant
  end
end
