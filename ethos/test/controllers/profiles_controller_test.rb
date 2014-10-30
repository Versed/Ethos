require 'test_helper'

class ProfilesControllerTest < ActionController::TestCase
  test "should get show" do
    get :show, id: users(:nathan).email
    assert_response :success
    assert_template 'profiles/show'
  end

  test "should render 404 page when profile is not found" do
    get :show, id: "doesn't exist"
    assert_response :not_found
  end

  test "should only show correct ideaboards on profiles" do
    get :show, id: users(:nathan).username
    assigns(:ideaboards).each do |ideaboard|
      assert_equal users(:nathan), ideaboard.user
    end
  end
end
