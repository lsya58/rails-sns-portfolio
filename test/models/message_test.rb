require "test_helper"

class MessageTest < ActiveSupport::TestCase
  def setup
    @room = Room.create
    @room.users << [users(:one), users(:two)]
    @message = @room.messages.build(content: "Hello", user: users(:one))
  end

  test "should be valid" do
    assert @message.valid?
  end

  test "content should be present" do
    @message.content = "   "
    assert_not @message.valid?
  end

  test "should require a user" do
    @message.user = nil
    assert_not @message.valid?
  end

  test "should require a room" do
    @message.room = nil
    assert_not @message.valid?
  end
end