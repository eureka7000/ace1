require 'test_helper'

class UnitConceptSelfEvaluationsControllerTest < ActionController::TestCase
  setup do
    @unit_concept_self_evaluation = unit_concept_self_evaluations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:unit_concept_self_evaluations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create unit_concept_self_evaluation" do
    assert_difference('UnitConceptSelfEvaluation.count') do
      post :create, unit_concept_self_evaluation: { comment: @unit_concept_self_evaluation.comment, evaluation: @unit_concept_self_evaluation.evaluation, unit_concept_id: @unit_concept_self_evaluation.unit_concept_id }
    end

    assert_redirected_to unit_concept_self_evaluation_path(assigns(:unit_concept_self_evaluation))
  end

  test "should show unit_concept_self_evaluation" do
    get :show, id: @unit_concept_self_evaluation
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @unit_concept_self_evaluation
    assert_response :success
  end

  test "should update unit_concept_self_evaluation" do
    patch :update, id: @unit_concept_self_evaluation, unit_concept_self_evaluation: { comment: @unit_concept_self_evaluation.comment, evaluation: @unit_concept_self_evaluation.evaluation, unit_concept_id: @unit_concept_self_evaluation.unit_concept_id }
    assert_redirected_to unit_concept_self_evaluation_path(assigns(:unit_concept_self_evaluation))
  end

  test "should destroy unit_concept_self_evaluation" do
    assert_difference('UnitConceptSelfEvaluation.count', -1) do
      delete :destroy, id: @unit_concept_self_evaluation
    end

    assert_redirected_to unit_concept_self_evaluations_path
  end
end
