require "test_helper"

class UserMailerTest < ActionMailer::TestCase
  test "password_reset" do
    user = users(:one)
    user.reset_token = User.new_token
    user.create_reset_digest
    mail = UserMailer.password_reset(user)
    
    assert_equal "パスワードリセット", mail.subject
    assert_equal [user.email], mail.to
    
    body = mail.body.parts.first.body.to_s
    assert_match user.reset_token, body
    assert_match CGI.escape(user.email), body
  end
end