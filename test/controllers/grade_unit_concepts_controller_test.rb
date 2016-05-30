require 'test_helper'

class GradeUnitConceptsControllerTest < ActionController::TestCase
  setup do
    @grade_unit_concept = grade_unit_concepts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:grade_unit_concepts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create grade_unit_concept" do
    assert_difference('GradeUnitConcept.count') do
      post :create, grade_unit_concept: { category: @grade_unit_concept.category, chapter: @grade_unit_concept.chapter, code: @grade_unit_concept.code, grade: @grade_unit_concept.grade, sub_category: @grade_unit_concept.sub_category, unit_concept: @grade_unit_concept.unit_concept }
    end

    assert_redirected_to grade_unit_concept_path(assigns(:grade_unit_concept))
  end

  test "should show grade_unit_concept" do
    get :show, id: @grade_unit_concept
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @grade_unit_concept
    assert_response :success
  end

  test "should update grade_unit_concept" do
    patch :update, id: @grade_unit_concept, grade_unit_concept: { category: @grade_unit_concept.category, chapter: @grade_unit_concept.chapter, code: @grade_unit_concept.code, grade: @grade_unit_concept.grade, sub_category: @grade_unit_concept.sub_category, unit_concept: @grade_unit_concept.unit_concept }
    assert_redirected_to grade_unit_concept_path(assigns(:grade_unit_concept))
  end

  test "should destroy grade_unit_concept" do
    assert_difference('GradeUnitConcept.count', -1) do
      delete :destroy, id: @grade_unit_concept
    end

    assert_redirected_to grade_unit_concepts_path
  end
end
