require 'test_helper'

class GetHisotyTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:nona)
    @other = users(:other)
    @user_token = api_keys(:nonas).access_token
    @other_token = api_keys(:others).access_token
  end

  test "send yo and get history" do
    post yo_path(@other), { format: :json }, { "X-API-TOKEN": @user_token }
    get history_path, { format: :json }, { "X-API-TOKEN": @other_token }
    assert_response :ok
    json = response_json
    assert { json["count"] == 1 }
    assert { not json["history"].nil? }
    assert { json["history"].count == 1 }
    assert { json["history"][0]["user"] == @user.name }
    assert { not json["history"][0]["yoed_at"].nil? }
  end
end
