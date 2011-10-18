require 'test_helper'

class SpayNeutersControllerTest < ActionController::TestCase
  setup do
    @spay_neuter = spay_neuters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:spay_neuters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create spay_neuter" do
    assert_difference('SpayNeuter.count') do
      post :create, :spay_neuter => @spay_neuter.attributes
    end

    assert_redirected_to spay_neuter_path(assigns(:spay_neuter))
  end

  test "should show spay_neuter" do
    get :show, :id => @spay_neuter.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @spay_neuter.to_param
    assert_response :success
  end

  test "should update spay_neuter" do
    put :update, :id => @spay_neuter.to_param, :spay_neuter => @spay_neuter.attributes
    assert_redirected_to spay_neuter_path(assigns(:spay_neuter))
  end

  test "should destroy spay_neuter" do
    assert_difference('SpayNeuter.count', -1) do
      delete :destroy, :id => @spay_neuter.to_param
    end

    assert_redirected_to spay_neuters_path
  end
end
