require 'test_helper'

class Front::HomesControllerTest < ActionController::TestCase
  setup do
    @front_home = front_homes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:front_homes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create front_home" do
    assert_difference('Front::Home.count') do
      post :create, front_home: {  }
    end

    assert_redirected_to front_home_path(assigns(:front_home))
  end

  test "should show front_home" do
    get :show, id: @front_home
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @front_home
    assert_response :success
  end

  test "should update front_home" do
    patch :update, id: @front_home, front_home: {  }
    assert_redirected_to front_home_path(assigns(:front_home))
  end

  test "should destroy front_home" do
    assert_difference('Front::Home.count', -1) do
      delete :destroy, id: @front_home
    end

    assert_redirected_to front_homes_path
  end
end
