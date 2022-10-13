class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  scope :all_except, -> (user) { where.not(id: user) }

  has_many :messages, dependent: :destroy 
  has_many :joinables, dependent: :destroy
  has_many :joined_rooms, through: :joinables,source: :room

  after_create_commit {broadcast_append_to "users"}

  after_update_commit {broadcast_update}
  
  after_commit :add_default_avatar, on: %i[create update]
 
  after_initialize :set_default_role, if: :new_record?
  
  enum status: %i[offline away online]
  enum role: %i[user admin]

  def set_default_role
    self.role ||= :user
  end

  has_one_attached :avatar do |image|
    image.variant :avatar_thumbnail, resize_to_limit: [100, 100]
    image.variant :chat_avatar, resize_to_limit: [100, 100]
  end


  def avatar_thumbnail
    # return if avatar.attached?
    avatar.variant(resize_to_limit: [150, 150]).processed
  end

  # def chat_avatar
  #   avatar.variant(resize_to_limit: [50, 50]).processed
  # end

  def broadcast_update
    # debugger
    broadcast_replace_to "user_status",partial: 'users/status',user: self 
  end

  def has_joined_room(room)
    joined_rooms.include?(room)
  end
  
  def status_to_css
    case status
    when 'online'
      'background-color: green'
    when 'away'
      'background-color: yellow'
    when 'offline'
      'background-color: gray'
    else
      'background-color: red'
    end
  end
  
  private

  def add_default_avatar
    return if avatar.attached?

    avatar.attach(
      io: File.open(Rails.root.join('app', 'assets', 'images', 'default_profile.jpg')),
      filename: 'default_profile.jpg'
    )
  end

 
end
