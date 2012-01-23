require 'test_helper'

class MonitoramentosControllerTest < ActionController::TestCase
  setup do
    @monitoramento = monitoramentos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:monitoramentos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create monitoramento" do
    assert_difference('Monitoramento.count') do
      post :create, :monitoramento => @monitoramento.attributes
    end

    assert_redirected_to monitoramento_path(assigns(:monitoramento))
  end

  test "should show monitoramento" do
    get :show, :id => @monitoramento.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @monitoramento.to_param
    assert_response :success
  end

  test "should update monitoramento" do
    put :update, :id => @monitoramento.to_param, :monitoramento => @monitoramento.attributes
    assert_redirected_to monitoramento_path(assigns(:monitoramento))
  end

  test "should destroy monitoramento" do
    assert_difference('Monitoramento.count', -1) do
      delete :destroy, :id => @monitoramento.to_param
    end

    assert_redirected_to monitoramentos_path
  end
end
