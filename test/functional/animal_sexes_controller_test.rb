require 'test_helper'

class AnimalSexesControllerTest < ActionController::TestCase
  setup do
    @animal_sex = animal_sexes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:animal_sexes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create animal_sex" do
    assert_difference('AnimalSex.count') do
      post :create, :animal_sex => @animal_sex.attributes
    end

    assert_redirected_to animal_sex_path(assigns(:animal_sex))
  end

  test "should show animal_sex" do
    get :show, :id => @animal_sex.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @animal_sex.to_param
    assert_response :success
  end

  test "should update animal_sex" do
    put :update, :id => @animal_sex.to_param, :animal_sex => @animal_sex.attributes
    assert_redirected_to animal_sex_path(assigns(:animal_sex))
  end

  test "should destroy animal_sex" do
    assert_difference('AnimalSex.count', -1) do
      delete :destroy, :id => @animal_sex.to_param
    end

    assert_redirected_to animal_sexes_path
  end
end
