require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "OpenYo", email: "OpenYo@nna774.net",
                     password: "openyo", password_confirmation: "openyo")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should not be blank" do
    @user.name = ""
    assert_not @user.valid?
  end

  test "name should be unique" do
    clone_user = @user.dup
    @user.save
    assert_not clone_user.valid?
  end

  test "name should be unique(case insensitive)" do
    clone_user = @user.dup
    clone_user.name = clone_user.name.upcase
    @user.save
    assert_not clone_user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 32
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end
end
