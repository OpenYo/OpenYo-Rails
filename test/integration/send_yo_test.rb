require 'test_helper'

class SendYoTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:nona)
    @other = users(:other)
  end

  test "send yo from nona to other" do
    token = api_keys(:nonas).access_token
    assert_difference [ '@other.yos.count'], 1 do
      post yo_path(@other), { format: :json }, { "X-API-TOKEN": token }
    end
    assert_template 'yos/sent_yo'
    assert_equal 201, response.status
    json = JSON.parse(response.body)
    assert { json["text"] == "sent Yo!" }
  end
end
