require 'test_helper'

class CreateApiTokenTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:nona)
    @other = users(:other)
  end

  test "create api_token with valid password" do
    assert_difference '@user.api_keys.count', 1 do
      post token_path, format: :json, name: @user.name, password: 'password'
    end
    assert_template 'users/new_token'
    assert_response :created
    json = response_json
    assert { not json["token"].nil? }
  end

  test "create api_token with invalid password" do
    assert_no_difference '@user.api_keys.count' do
      post token_path, format: :json, name: @user.name, password: 'this is invalid pass'
    end
    assert_template 'application/authentication_required'
    assert_response :unauthorized
    json = response_json
    assert { json["token"].nil? }
    assert { json["text"] == "unauthorized" }
  end

  test "create api_token and send yo with that token" do
    post token_path, format: :json, name: @user.name, password: 'password'
    json = response_json
    token = json["token"]
    assert_difference [ '@other.yos.count' ], 1 do
      post yo_path(@other), { format: :json }, { "X-API-TOKEN": token }
    end
    assert_template 'yos/sent_yo'
    assert_response :created
    json = response_json
    assert { json["text"] == "sent Yo!" }
  end
end
