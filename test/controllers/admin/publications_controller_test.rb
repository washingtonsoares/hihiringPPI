require 'test_helper'

class Admin::PublicationsControllerTest < ActionController::TestCase
  setup do
    @admin_publication = admin_publications(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_publications)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_publication" do
    assert_difference('Admin::Publication.count') do
      post :create, admin_publication: { resume: @admin_publication.resume, title: @admin_publication.title, user_id: @admin_publication.user_id }
    end

    assert_redirected_to admin_publication_path(assigns(:admin_publication))
  end

  test "should show admin_publication" do
    get :show, id: @admin_publication
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_publication
    assert_response :success
  end

  test "should update admin_publication" do
    patch :update, id: @admin_publication, admin_publication: { resume: @admin_publication.resume, title: @admin_publication.title, user_id: @admin_publication.user_id }
    assert_redirected_to admin_publication_path(assigns(:admin_publication))
  end

  test "should destroy admin_publication" do
    assert_difference('Admin::Publication.count', -1) do
      delete :destroy, id: @admin_publication
    end

    assert_redirected_to admin_publications_path
  end
end
