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

  test "get history(limit)" do
    10.times do
      post yo_path(@other), { format: :json }, { "X-API-TOKEN": @user_token }
    end
    get history_path, { format: :json, limit: 5 }, { "X-API-TOKEN": @other_token }
    assert_response :ok
    json = response_json
    assert { json["count"] == 5 }
    assert { not json["history"].nil? }
    assert { json["history"].count == 5 }
    5.times do |i|
      assert { json["history"][i]["user"] == @user.name }
      assert { not json["history"][i]["yoed_at"].nil? }
    end
  end

  test "get history(limit and page)" do
    25.times do
      post yo_path(@other), { format: :json }, { "X-API-TOKEN": @user_token }
    end
    get history_path, { format: :json, limit: 10, page: 3 }, { "X-API-TOKEN": @other_token }
    assert_response :ok
    json = response_json
    assert { json["count"] == 5 }
    assert { not json["history"].nil? }
    assert { json["history"].count == 5 }
    5.times do |i|
      assert { json["history"][i]["user"] == @user.name }
      assert { not json["history"][i]["yoed_at"].nil? }
    end
  end

  test "get history(since)" do
    post yo_path(@other), { format: :json }, { "X-API-TOKEN": @user_token }
    sleep 1 # sleep したくない～～。
    time = Time.now.utc
    sleep 1
    post yo_path(@other), { format: :json }, { "X-API-TOKEN": @user_token }
    get history_path, { format: :json, since: time.to_s }, { "X-API-TOKEN": @other_token }
    assert_response :ok
    json = response_json
    assert { json["count"] == 1 }
    assert { not json["history"].nil? }
    assert { json["history"].count == 1 }
    assert { json["history"][0]["user"] == @user.name }
    assert { not json["history"][0]["yoed_at"].nil? }
  end

  test "get history(since local time)" do
    post yo_path(@other), { format: :json }, { "X-API-TOKEN": @user_token }
    sleep 1 # sleep したくない～～。
    time = Time.now
    sleep 1
    post yo_path(@other), { format: :json }, { "X-API-TOKEN": @user_token }
    get history_path, { format: :json, since: time.to_s }, { "X-API-TOKEN": @other_token }
    assert_response :ok
    json = response_json
    assert { json["count"] == 1 }
    assert { not json["history"].nil? }
    assert { json["history"].count == 1 }
    assert { json["history"][0]["user"] == @user.name }
    assert { not json["history"][0]["yoed_at"].nil? }
  end
end
