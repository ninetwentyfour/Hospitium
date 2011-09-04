require 'test_helper'

class RelinquishmentContactsControllerTest < ActionController::TestCase
  setup do
    @relinquishment_contact = relinquishment_contacts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:relinquishment_contacts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create relinquishment_contact" do
    assert_difference('RelinquishmentContact.count') do
      post :create, :relinquishment_contact => @relinquishment_contact.attributes
    end

    assert_redirected_to relinquishment_contact_path(assigns(:relinquishment_contact))
  end

  test "should show relinquishment_contact" do
    get :show, :id => @relinquishment_contact.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @relinquishment_contact.to_param
    assert_response :success
  end

  test "should update relinquishment_contact" do
    put :update, :id => @relinquishment_contact.to_param, :relinquishment_contact => @relinquishment_contact.attributes
    assert_redirected_to relinquishment_contact_path(assigns(:relinquishment_contact))
  end

  test "should destroy relinquishment_contact" do
    assert_difference('RelinquishmentContact.count', -1) do
      delete :destroy, :id => @relinquishment_contact.to_param
    end

    assert_redirected_to relinquishment_contacts_path
  end
end
