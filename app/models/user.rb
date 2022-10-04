class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  scope :all_except, -> (user) { where.not(id: user) }

  has_many :messages


  after_create_commit {broadcast_append_to "users"}

  has_one_attached :avatar do |image|
    image.variant :avatar_thumbnail, resize_to_limit: [100, 100]
    image.variant :chat_avatar, resize_to_limit: [100, 100]
  end

  after_commit :add_default_avatar, on: %i[create update]

  # def avatar_thumbnail
  #   return if avatar.attached?
  #   avatar.variant(resize_to_limit: [150, 150]).processed
  # end

  # def chat_avatar
  #   avatar.variant(resize_to_limit: [50, 50]).processed
  # end

  private

  def add_default_avatar
    return if avatar.attached?

    avatar.attach(
      io: File.open(Rails.root.join('app', 'assets', 'images', 'default_profile.jpg')),
      filename: 'default_profile.jpg',
      content_type: 'image/jpg'
    )
  end
end
