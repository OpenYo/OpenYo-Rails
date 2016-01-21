require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def setup
    @user = users(:nona)
  end

  test "should get show with name" do
    get :show, name: @user.name
    assert_response :success
  end

  test "should get show with name(format: json)" do
    get :show, name: @user.name, format: :json
    assert_response :success
    json = JSON.parse(response.body)
    assert_equal @user.name, json["name"]
    assert_not_nil json["created_at"]
  end
end
