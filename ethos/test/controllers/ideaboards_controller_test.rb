require 'test_helper'

class IdeaboardsControllerTest < ActionController::TestCase
 test "should redirect when not logged in" do
  get :new
  assert_response :redirect
  assert_redirected_to new_user_session_path
 end

 test "should render new page when logged in" do
  sign_in users(:nathan)
  get :new
  assert_response :success
 end
end
