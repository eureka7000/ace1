require 'test_helper'

class ConceptsControllerTest < ActionController::TestCase
  setup do
    @concept = concepts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:concepts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create concept" do
    assert_difference('Concept.count') do
      post :create, concept: { category: @concept.category, concept_code: @concept.concept_code, concept_name: @concept.concept_name, sub_category: @concept.sub_category }
    end

    assert_redirected_to concept_path(assigns(:concept))
  end

  test "should show concept" do
    get :show, id: @concept
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @concept
    assert_response :success
  end

  test "should update concept" do
    patch :update, id: @concept, concept: { category: @concept.category, concept_code: @concept.concept_code, concept_name: @concept.concept_name, sub_category: @concept.sub_category }
    assert_redirected_to concept_path(assigns(:concept))
  end

  test "should destroy concept" do
    assert_difference('Concept.count', -1) do
      delete :destroy, id: @concept
    end

    assert_redirected_to concepts_path
  end
end
