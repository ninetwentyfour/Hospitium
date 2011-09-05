require 'test_helper'

class AnimalColorsControllerTest < ActionController::TestCase
  setup do
    @animal_color = animal_colors(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:animal_colors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create animal_color" do
    assert_difference('AnimalColor.count') do
      post :create, :animal_color => @animal_color.attributes
    end

    assert_redirected_to animal_color_path(assigns(:animal_color))
  end

  test "should show animal_color" do
    get :show, :id => @animal_color.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @animal_color.to_param
    assert_response :success
  end

  test "should update animal_color" do
    put :update, :id => @animal_color.to_param, :animal_color => @animal_color.attributes
    assert_redirected_to animal_color_path(assigns(:animal_color))
  end

  test "should destroy animal_color" do
    assert_difference('AnimalColor.count', -1) do
      delete :destroy, :id => @animal_color.to_param
    end

    assert_redirected_to animal_colors_path
  end
end
