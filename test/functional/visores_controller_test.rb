require 'test_helper'

class VisoresControllerTest < ActionController::TestCase
  setup do
    @visor = visores(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:visores)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create visor" do
    assert_difference('Visor.count') do
      post :create, :visor => @visor.attributes
    end

    assert_redirected_to visor_path(assigns(:visor))
  end

  test "should show visor" do
    get :show, :id => @visor.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @visor.to_param
    assert_response :success
  end

  test "should update visor" do
    put :update, :id => @visor.to_param, :visor => @visor.attributes
    assert_redirected_to visor_path(assigns(:visor))
  end

  test "should destroy visor" do
    assert_difference('Visor.count', -1) do
      delete :destroy, :id => @visor.to_param
    end

    assert_redirected_to visores_path
  end
end
