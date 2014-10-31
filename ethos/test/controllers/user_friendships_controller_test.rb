require 'test_helper'

class UserFriendshipsControllerTest < ActionController::TestCase
  context "#new" do
    context "when not logged in" do
      should "redirect to the login page" do
        get :new
        assert_response :redirect
      end
    end

    context "when logged in" do
      setup do
        sign_in users(:nathan)
      end

      should "get new and return success" do
        get :new
        assert_response :success
      end

      should "get a flash error if friend_id param is missing" do
        get :new, {}
        assert_equal "Friend required", flash[:error]
      end

      should "display the friends name" do
        get :new, friend_id: users(:joe)
        assert_match /#{users(:joe).full_name}/, response.body
      end

      should "assign a new user friendship" do
        get :new, friend_id: users(:joe)
        assert users(:joe), assigns(:user_friendship).friend
      end

      should "assign a new user friendship to current user" do
        get :new, friend_id: users(:joe)
        assert users(:nathan), assigns(:user_friendship).user
      end

      should "return 404 if no friend is found" do
        get :new, friend_id: 'new'
        assert_response :not_found
      end

      should "ask if you really want to request friendship" do
        get :new, friend_id: users(:joe)
        assert_match /Do you really want to friend #{useres(:jim).full_name}?/, response.body
      end

      should "call to_param on user returns profile name" do
        assert_equal "nlkluth", users(:nathan).to_param
      end
    end
  end

  context "#create" do
    context "when not logged in" do
      should "redirect to the login page" do
        get :new
        assert_response :redirect
      end
    end

    context "when logged in" do
      setup do
        sign_in users(:nathan)
      end

      should "redirect with no friend id" do
        post :create
        assert !flash[:error].empty?
        assert_redirected_to root_path
      end

      should "create friendship with friend id" do
        post :create, user_friendship: { friend_id: users(:mike) }
        assert assigns(:friend)
        asser_equal users(:mike), assigns(:friend)
        assert assigns(:user_friendship)
        assert_equal users(:nathan), assigns(:user_friendship).user
        assert_equal users(:mike), assigns(:user_friendship).friend

        assert users(:nathan).friends.include?(users(:mike))
        assert_response :redirect
        assert_redirected_to profile_path(users(:mike))
        assert flash[:success]
        assert_equal "You are now friends with #{users(:mike).full_name}", flash[:success]
      end
    end
  end
end
