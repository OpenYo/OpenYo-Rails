require 'test_helper'

class SendYoTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:nona)
    @other = User.create(name: "other", email: "other@example.com", password: "hogehoge", password_confirmation: "hogehoge")
  end

  test "send yo to other" do # '@user.yos.count',
    assert_difference [ '@other.yos.count'], 1 do
      post yo_path(@other), user: @user, format: :json
    end
    # assert_template 'users/creation_success'
    # assert_equal 201, response.status
    # json = JSON.parse(response.body)
    # assert_nil json["text"]
    # assert_not_nil json["name"]
    # assert_not_nil json["url"]
  end
end
