require 'test_helper'

class AnimalWeightsControllerTest < ActionController::TestCase
  setup do
    @animal_weight = animal_weights(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:animal_weights)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create animal_weight" do
    assert_difference('AnimalWeight.count') do
      post :create, :animal_weight => @animal_weight.attributes
    end

    assert_redirected_to animal_weight_path(assigns(:animal_weight))
  end

  test "should show animal_weight" do
    get :show, :id => @animal_weight.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @animal_weight.to_param
    assert_response :success
  end

  test "should update animal_weight" do
    put :update, :id => @animal_weight.to_param, :animal_weight => @animal_weight.attributes
    assert_redirected_to animal_weight_path(assigns(:animal_weight))
  end

  test "should destroy animal_weight" do
    assert_difference('AnimalWeight.count', -1) do
      delete :destroy, :id => @animal_weight.to_param
    end

    assert_redirected_to animal_weights_path
  end
end
