require 'test_helper'

class BitersControllerTest < ActionController::TestCase
  setup do
    @biter = biters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:biters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create biter" do
    assert_difference('Biter.count') do
      post :create, :biter => @biter.attributes
    end

    assert_redirected_to biter_path(assigns(:biter))
  end

  test "should show biter" do
    get :show, :id => @biter.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @biter.to_param
    assert_response :success
  end

  test "should update biter" do
    put :update, :id => @biter.to_param, :biter => @biter.attributes
    assert_redirected_to biter_path(assigns(:biter))
  end

  test "should destroy biter" do
    assert_difference('Biter.count', -1) do
      delete :destroy, :id => @biter.to_param
    end

    assert_redirected_to biters_path
  end
end
