require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def setup
    @user = users(:nona)
    @user_query = {
      name: "example",
      email: "example@example.com",
      password: "foobar",
      password_confirmation: "foobar"
    }
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

  test "invalid signup" do
    invalid = @user_query.dup
    invalid[:name] = ""
    post :create, user: invalid, format: :json
    assert_response :bad_request
    json = JSON.parse(response.body)
    assert_not_nil json["text"]
  end

  test "valid signup" do
    post :create, user: @user_query, format: :json
    assert_response :success
    json = JSON.parse(response.body)
    assert { json["name"] == @user_query[:name] }
    assert { json["url"] == user_path(@user_query[:name]) }
  end
end
