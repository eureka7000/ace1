require 'test_helper'

class ExplanationsControllerTest < ActionController::TestCase
  setup do
    @explanation = explanations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:explanations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create explanation" do
    assert_difference('Explanation.count') do
      post :create, explanation: { code: @explanation.code }
    end

    assert_redirected_to explanation_path(assigns(:explanation))
  end

  test "should show explanation" do
    get :show, id: @explanation
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @explanation
    assert_response :success
  end

  test "should update explanation" do
    patch :update, id: @explanation, explanation: { code: @explanation.code }
    assert_redirected_to explanation_path(assigns(:explanation))
  end

  test "should destroy explanation" do
    assert_difference('Explanation.count', -1) do
      delete :destroy, id: @explanation
    end

    assert_redirected_to explanations_path
  end
end
