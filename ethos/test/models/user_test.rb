require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should have_many(:user_friendships)
  should have_many(:friends)

  should have_many(:pending_user_friendships)
  should have_many(:pending_friends)

  should have_many(:requested_user_friendships)
  should have_many(:requested_friends)

  should have_many(:blocked_user_friendships)
  should have_many(:blocked_friends)

  should have_many(:activities)

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

  context "#has_blocked" do
    should "return true if blocked" do
      assert users(:nathan).has_blocked?(users(:blocked_friend))
      assert !users(:nathan).has_blocked?(users(:joe))
    end
  end

  context "#create_activity" do
    should "increase the Activity count" do
      assert_difference 'Activity.count' do
        users(:nathan).create_activity(ideaboards(:one), 'created')
      end
    end

    should "set the targetable instance to the item passed in" do
      activity = users(:nathan).create_activity(ideaboards(:one), 'created')
      assert_equal ideaboards(:one), activity.targetable
    end
  end

  context "#subscribe_to_mailchimp" do
    @user = User.new
    it "calls mailchimp correctly" do
      opts = {
        email: {email: @user.email},
        id: ENV['MAILCHIMP_LIST_ID'],
        double_optin: false,
      }

      mail_list = Rails.configuration.mailchimp.lists.class
      mail_list.any_instance.should_receive(:subscribe).with(opts).once
      @user.send(:subscribe_to_mailchimp, true)
    end
  end
end
