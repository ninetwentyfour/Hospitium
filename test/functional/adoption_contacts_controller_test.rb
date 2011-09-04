require 'test_helper'

class AdoptionContactsControllerTest < ActionController::TestCase
  setup do
    @adoption_contact = adoption_contacts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:adoption_contacts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create adoption_contact" do
    assert_difference('AdoptionContact.count') do
      post :create, :adoption_contact => @adoption_contact.attributes
    end

    assert_redirected_to adoption_contact_path(assigns(:adoption_contact))
  end

  test "should show adoption_contact" do
    get :show, :id => @adoption_contact.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @adoption_contact.to_param
    assert_response :success
  end

  test "should update adoption_contact" do
    put :update, :id => @adoption_contact.to_param, :adoption_contact => @adoption_contact.attributes
    assert_redirected_to adoption_contact_path(assigns(:adoption_contact))
  end

  test "should destroy adoption_contact" do
    assert_difference('AdoptionContact.count', -1) do
      delete :destroy, :id => @adoption_contact.to_param
    end

    assert_redirected_to adoption_contacts_path
  end
end
