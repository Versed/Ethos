require 'test_helper'

class ProfilesControllerTest < ActionController::TestCase
  test "should get show" do
    get :show, id: user(:nathan).email
    assert_response :success
    assert_template 'profiles/show'
  end

  test "should render 404 page when profile is not found" do
    get :show, id: "doesn't exist"
    assert_response :not_found
  end
end
