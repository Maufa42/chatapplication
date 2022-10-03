class Room < ApplicationRecord
  validates_uniqueness_of :name

  
  scope :public_rooms, -> {where(private: false)}
end
