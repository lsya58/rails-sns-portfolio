require "test_helper"

class RoomsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
  end

  test "should redirect index when not logged in" do
    get rooms_path
    assert_redirected_to login_url
  end

  test "should redirect show when not logged in" do
    room = Room.create
    room.users << [users(:one), users(:two)]
    get room_path(room)
    assert_redirected_to login_url
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Room.count' do
      post rooms_path, params: { user_id: users(:two).id }
    end
    assert_redirected_to login_url
  end
end