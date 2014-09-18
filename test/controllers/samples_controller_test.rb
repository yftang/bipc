require 'test_helper'

class SamplesControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get update" do
    get :update
    assert_response :success
  end

  test "should get destroy" do
    get :destroy
    assert_response :success
  end

  test "should get edit" do
    get :edit
    assert_response :success
  end

  test "should get receive" do
    get :receive
    assert_response :success
  end

end
