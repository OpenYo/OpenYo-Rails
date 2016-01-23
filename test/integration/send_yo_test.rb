require 'test_helper'

class SendYoTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:nona)
    @other = users(:other)
  end

  test "send yo from nona to other" do
    token = api_keys(:nonas).access_token
    assert_difference [ '@other.yos.count', '@other.friends.count', '@user.friends.count' ], 1 do
      post yo_path(@other), { format: :json }, { "X-API-TOKEN": token }
    end
    assert_template 'yos/sent_yo'
    assert_response :created
    json = JSON.parse(response.body)
    assert { json["text"] == "sent Yo!" }
  end

  test "send yo to other without any token" do
    assert_no_difference [ '@other.yos.count', '@other.friends.count', '@user.friends.count' ] do
      post yo_path(@other), { format: :json }
    end
    assert_template 'application/authentication_required'
    assert_response :unauthorized
    json = JSON.parse(response.body)
    assert { json["text"] == "unauthorized" }
  end
end
