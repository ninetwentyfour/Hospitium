require 'test_helper'

class VetContactsControllerTest < ActionController::TestCase
  setup do
    @vet_contact = vet_contacts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:vet_contacts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create vet_contact" do
    assert_difference('VetContact.count') do
      post :create, :vet_contact => @vet_contact.attributes
    end

    assert_redirected_to vet_contact_path(assigns(:vet_contact))
  end

  test "should show vet_contact" do
    get :show, :id => @vet_contact.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @vet_contact.to_param
    assert_response :success
  end

  test "should update vet_contact" do
    put :update, :id => @vet_contact.to_param, :vet_contact => @vet_contact.attributes
    assert_redirected_to vet_contact_path(assigns(:vet_contact))
  end

  test "should destroy vet_contact" do
    assert_difference('VetContact.count', -1) do
      delete :destroy, :id => @vet_contact.to_param
    end

    assert_redirected_to vet_contacts_path
  end
end
