require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should have_many(:user_friendships)
  should have_many(:friends)

  should have_many(:pending_user_friendships)
  should have_many(:pending_friends)

  should have_many(:requested_user_friendships)
  should have_many(:requested_friends)

  test "a user should enter a first name" do
    user = User.new
    assert !user.save
    assert !user.errors[:first_name].empty?
  end

  test "a user should enter a last name" do
    user = User.new
    assert !user.save
    assert !user.errors[:last_name].empty?
  end

  test "a user should be able to access a friends list without an exception" do
    assert_nothing_raised do
      users(:nathan).friends
    end
  end

  test "that creating friendships works" do
    users(:nathan).pending_friends << users(:mike)
    users(:nathan).pending_friends.reload
    assert users(:nathan).pending_friends.include?(users(:mike))
  end
end
