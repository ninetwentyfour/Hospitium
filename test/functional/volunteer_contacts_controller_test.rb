require 'test_helper'

class VolunteerContactsControllerTest < ActionController::TestCase
  setup do
    @volunteer_contact = volunteer_contacts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:volunteer_contacts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create volunteer_contact" do
    assert_difference('VolunteerContact.count') do
      post :create, :volunteer_contact => @volunteer_contact.attributes
    end

    assert_redirected_to volunteer_contact_path(assigns(:volunteer_contact))
  end

  test "should show volunteer_contact" do
    get :show, :id => @volunteer_contact.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @volunteer_contact.to_param
    assert_response :success
  end

  test "should update volunteer_contact" do
    put :update, :id => @volunteer_contact.to_param, :volunteer_contact => @volunteer_contact.attributes
    assert_redirected_to volunteer_contact_path(assigns(:volunteer_contact))
  end

  test "should destroy volunteer_contact" do
    assert_difference('VolunteerContact.count', -1) do
      delete :destroy, :id => @volunteer_contact.to_param
    end

    assert_redirected_to volunteer_contacts_path
  end
end
