require 'test_helper'

class PendingTransactionsControllerTest < ActionController::TestCase
  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get confirm" do
    get :confirm
    assert_response :success
  end

  test "should get index" do
    get :index
    assert_response :success
  end

end
