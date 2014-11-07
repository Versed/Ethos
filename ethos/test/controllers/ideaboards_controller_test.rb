require 'test_helper'

class IdeaboardsControllerTest < ActionController::TestCase
  test "should not display blocked users ideaboards if logged in" do
    sign_in users(:nathan)
    users(:blocked_friend).ideaboards.create(description: 'blocked idea')
    users(:joe).ideaboards.create(description: 'non-blocked')
    get :index
    assert_match /non\-blocked/, response.body
    assert_no_match /blocked\ idea/, response.body
  end

  test "should display all users ideaboards if not logged in" do
    sign_in users(:nathan)
    users(:blocked_friend).ideaboards.create(description: 'blocked idea')
    users(:joe).ideaboards.create(description: 'non-blocked')
    get :index
    assert_match /non\-blocked/, response.body
    assert_match /blocked\ idea/, response.body
  end

  test "should redirect when not logged in" do
    get :new
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test "should be logged in to post a ideaboard" do
    post :create, ideaboard: { title: "Test", description: "testing" }
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test "should render new page when logged in" do
    sign_in users(:nathan)
    get :new
    assert_response :success
  end

  test "should be able to post ideaboard when logged in" do
    sign_in users(:nathan)

    assert_difference('Ideaboard.count') do
      post :create, ideaboard: { title: "Test", description: "testing", user_id: users(:joe).id }
    end

    assert_redirected_to ideaboard_path(assigns(:idea))
    assert_equal assigns(:ideaboard).user_id, users(:nathan).id
  end

  test "should get edit when logged in" do
    sign_in users(:nathan)
    get :edit, id: @ideaboard
    assert_response :success
  end

  test "should redirect update when not logged in" do
    ideaboard = Ideaboard.create(title: "test", description: "testing")
    put :update, id: ideaboard
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end
end
