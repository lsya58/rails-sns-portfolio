require "test_helper"

class RoomTest < ActiveSupport::TestCase
  def setup
    @room = Room.new
    @user1 = users(:one)
    @user2 = users(:two)
  end

  test "should be valid with two users" do
    @room.users << [@user1, @user2]
    assert @room.valid?
  end

  test "should find existing room between two users" do
    room = Room.create
    room.users << [@user1, @user2]
    
    found_room = Room.between(@user1, @user2)
    assert_equal room, found_room
  end

  test "should create new room if none exists" do
    user3 = users(:three)
    assert_difference 'Room.count', 1 do
      Room.between(@user1, user3)
    end
  end
end