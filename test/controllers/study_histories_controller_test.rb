require 'test_helper'

class StudyHistoriesControllerTest < ActionController::TestCase
  setup do
    @study_history = study_histories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:study_histories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create study_history" do
    assert_difference('StudyHistory.count') do
      post :create, study_history: { segment: @study_history.segment, status: @study_history.status, unit_concept_id: @study_history.unit_concept_id, user_id: @study_history.user_id }
    end

    assert_redirected_to study_history_path(assigns(:study_history))
  end

  test "should show study_history" do
    get :show, id: @study_history
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @study_history
    assert_response :success
  end

  test "should update study_history" do
    patch :update, id: @study_history, study_history: { segment: @study_history.segment, status: @study_history.status, unit_concept_id: @study_history.unit_concept_id, user_id: @study_history.user_id }
    assert_redirected_to study_history_path(assigns(:study_history))
  end

  test "should destroy study_history" do
    assert_difference('StudyHistory.count', -1) do
      delete :destroy, id: @study_history
    end

    assert_redirected_to study_histories_path
  end
end
