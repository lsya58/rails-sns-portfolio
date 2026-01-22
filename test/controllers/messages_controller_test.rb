require "test_helper"

class MessagesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @room = Room.create
    @room.users << [users(:one), users(:two)]
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Message.count' do
      post room_messages_path(@room), params: { message: { content: "Hello" } }
    end
    assert_redirected_to login_url
  end
end