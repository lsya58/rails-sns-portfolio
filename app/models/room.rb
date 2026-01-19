class Room < ApplicationRecord
  has_many :room_users, dependent: :destroy
  has_many :users, through: :room_users
  has_many :messages, dependent: :destroy

  def self.between(user1, user2)
    user1_rooms = user1.rooms.includes(:users)
    
    room = user1_rooms.find { |r| r.users.include?(user2) }
    
    room || create_room_for(user1, user2)
  end

  def self.create_room_for(user1, user2)
    room = Room.create
    room.users << [user1, user2]
    room
  end
end