require 'test_helper'

class UserTest2sControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_test2 = user_test2s(:one)
  end

  test "should get index" do
    get user_test2s_url
    assert_response :success
  end

  test "should get new" do
    get new_user_test2_url
    assert_response :success
  end

  test "should create user_test2" do
    assert_difference('UserTest2.count') do
      post user_test2s_url, params: { user_test2: { password: @user_test2.password, username: @user_test2.username } }
    end

    assert_redirected_to user_test2_url(UserTest2.last)
  end

  test "should show user_test2" do
    get user_test2_url(@user_test2)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_test2_url(@user_test2)
    assert_response :success
  end

  test "should update user_test2" do
    patch user_test2_url(@user_test2), params: { user_test2: { password: @user_test2.password, username: @user_test2.username } }
    assert_redirected_to user_test2_url(@user_test2)
  end

  test "should destroy user_test2" do
    assert_difference('UserTest2.count', -1) do
      delete user_test2_url(@user_test2)
    end

    assert_redirected_to user_test2s_url
  end
end
