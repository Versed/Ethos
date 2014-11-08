require 'test_helper'

class UserFriendshipTest < ActiveSupport::TestCase
  should belong_to(:user)
  should belong_to(:friend)

  test "that creating a friendship works without raising an exception" do
    assert_nothing_raised do
      UserFriendship.create user: users(:nathan), friend: users(:joe)
    end
  end

  test "that creating a friendship based on user id and friend id works" do
    UserFriendship.create user_id: users(:nathan).id, friend_id: users(:mike).id
    assert users(:nathan).pending_friends.include?(users(:mike))
  end

  context "a new instance" do
    setup do
      @user_friendship = UserFriendship.new user: users(:nathan), friend: users(:mike)
    end

    should "have a pending state" do
      assert_equal 'pending', @user_friendship.state
    end
  end

  context "#send_request_email" do
    setup do
      @user_friendship = UserFriendship.new user: users(:nathan), friend: users(:mike)
    end

    should "send an email" do
      assert_difference 'ActionMailer::Base.deliveries.size', 1 do
        @user_friendship.send_request_email
      end
    end
  end

  context "#accept!" do
    setup do
      @user_friendship = UserFriendship.request users(:nathan), users(:mike)
    end

    should "set the state to accepted" do
      @user_friendship.accept!
      assert_equal "accepted", @user_friendship.state
    end

    should "send an acceptance email" do
      assert_difference 'ActionMailer::Base.deliveries.size', 1 do
        @user_friendship.accept!
      end
    end

    should "include the friend in the list of friends" do
      @user_friendship.accept!
      users(:nathan).friends.reload
      assert users(:nathan).friends.include?(users(:mike))
    end

    should "accept the mutual friendship" do
      @user_friendship.accept!
      assert_equal 'accepted', @user_friendship.mutual_friendship.state
    end
  end

  context ".request" do
    should "create two user friendships" do
      assert_difference 'UserFriendship.count', 2 do
        UserFriendship.request(users(:nathan), users(:mike))
      end
    end

    should "send a friend request email" do
      assert_difference 'ActionMailer::Base.deliveries.size', 1 do
        UserFriendship.request(users(:nathan), users(:mike))
      end
    end
  end

  context "#delete_mutual_friendship!" do
    setup do
      UserFriendship.request users(:nathan), users(:joe)
      @friendship1 = create(:pending_user_friendship, user: users(:nathan), friend: create(:user, first_name: 'Pending', last_name: 'Friend'))
      @friendship2 = create(:accepted_user_friendship, user: users(:nathan), friend: create(:user, first_name: 'Active', last_name: 'Friend'))
    end

    should "delete the mutual friendship" do
      assert_equal @friendship2, @friendship1.mutual_friendship
      @friendship1.delete_mutual_friendship!

      assert !UserFriendship.exists?(@friendship2.id)
    end
  end

  context "on destroy" do
    setup do
      UserFriendship.request users(:nathan), users(:joe)
      @friendship1 = create(:pending_user_friendship, user: users(:nathan), friend: create(:user, first_name: 'Pending', last_name: 'Friend'))
      @friendship2 = create(:accepted_user_friendship, user: users(:nathan), friend: create(:user, first_name: 'Active', last_name: 'Friend'))
    end

    should "delete the mutual friendship" do
      @friendship1.destroy
      assert !UserFriendship.exists?(@friendship2.id)
    end
  end

  context "#block!" do
    setup do
      @user_friendship = UserFriendship.request users(:nathan), users(:mike)
    end

    should "set the state to blocked" do
      @user_friendship.block!
      assert_equal 'blocked', @user_friendship.state
      assert_equal 'blocked', @user_friendship.mutual_friendship.state
    end

    should "not allow a request to a blocked friendship" do
      @user_friendship.block!
      uf = UserFriendship.request users(:nathan), users(:mike)
      assert !uf.save
    end
  end
end
