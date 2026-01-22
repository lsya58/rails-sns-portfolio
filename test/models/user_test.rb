require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Example User", 
                     email: "user@example.com",
                     password: "foobar", 
                     password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "   "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "   "
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "password should be present" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticate("wrong_password")
  end

  test "associated microposts should be destroyed" do
    @user.save
    @user.microposts.create!(content: "Lorem ipsum")
    assert_difference 'Micropost.count', -1 do
      @user.destroy
    end
  end

  test "should follow and unfollow a user" do
  user1 = users(:one)
  user2 = users(:two)
  user3 = users(:three) 
  
  assert_not user1.following?(user3)
  user1.follow(user3)
  assert user1.following?(user3)
  assert user3.followers.include?(user1)
  user1.unfollow(user3)
  assert_not user1.following?(user3)
end

  test "feed should have the right posts" do
    user1 = users(:one)
    user2 = users(:two)
    user3 = users(:three)
    
    user2.microposts.each do |post_following|
      assert user1.feed.include?(post_following)
    end
    
    user1.microposts.each do |post_self|
      assert user1.feed.include?(post_self)
    end
    
    user3.microposts.each do |post_unfollowed|
      assert_not user1.feed.include?(post_unfollowed)
    end
  end
end