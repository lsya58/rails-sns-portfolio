require "test_helper"

class PasswordResetsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
  end

  test "should get new" do
    get new_password_reset_path
    assert_response :success
  end

  test "should get edit" do
    @user.create_reset_digest
    get edit_password_reset_path(@user.reset_token, email: @user.email)
    assert_response :success
  end

  test "should redirect edit with wrong email" do
    @user.create_reset_digest
    get edit_password_reset_path(@user.reset_token, email: "wrong@example.com")
    assert_redirected_to root_url
  end

  test "should redirect edit with expired token" do
    @user.create_reset_digest
    @user.update_column(:reset_sent_at, 3.hours.ago)
    get edit_password_reset_path(@user.reset_token, email: @user.email)
    assert_redirected_to new_password_reset_url
  end
end