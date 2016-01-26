require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    assert_no_difference 'User.count' do
      post users_path, name:  "",
                       email: "user@invalid",
                       password:              "foo",
                       password_confirmation: "bar",
                       format: :json
    end
    assert_template 'users/creation_fail'
    assert_equal 400, response.status
    json = response_json
    assert_not_nil json["text"]
  end

  test "old style signup is invalid" do
    assert_no_difference 'User.count' do
      post users_path, user: { name:  "example",
                               email: "user@example.com",
                               password:              "foobar",
                               password_confirmation: "foobar" },
                     format: :json
    end
    assert_template 'users/creation_fail'
    assert_equal 400, response.status
    json = response_json
    assert_not_nil json["text"]
  end

  test "valid signup information" do
    assert_difference 'User.count', 1 do
      post users_path, name:  "example",
                       email: "user@example.com",
                       password:              "foobar",
                       password_confirmation: "foobar",
                       format: :json
    end
    assert_template 'users/creation_success'
    assert_equal 201, response.status
    json = response_json
    assert_nil json["text"]
    assert_not_nil json["name"]
    assert_not_nil json["url"]
  end
end
