require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "OpenYo", email: "OpenYo@nna774.net")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should not be blank" do
    @user.name = ""
    assert_not @user.valid?
  end
end
