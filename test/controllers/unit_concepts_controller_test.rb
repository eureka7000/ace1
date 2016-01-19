require 'test_helper'

class UnitConceptsControllerTest < ActionController::TestCase
  setup do
    @unit_concept = unit_concepts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:unit_concepts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create unit_concept" do
    assert_difference('UnitConcept.count') do
      post :create, unit_concept: { code: @unit_concept.code, level: @unit_concept.level, name: @unit_concept.name }
    end

    assert_redirected_to unit_concept_path(assigns(:unit_concept))
  end

  test "should show unit_concept" do
    get :show, id: @unit_concept
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @unit_concept
    assert_response :success
  end

  test "should update unit_concept" do
    patch :update, id: @unit_concept, unit_concept: { code: @unit_concept.code, level: @unit_concept.level, name: @unit_concept.name }
    assert_redirected_to unit_concept_path(assigns(:unit_concept))
  end

  test "should destroy unit_concept" do
    assert_difference('UnitConcept.count', -1) do
      delete :destroy, id: @unit_concept
    end

    assert_redirected_to unit_concepts_path
  end
end
