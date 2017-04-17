require 'test_helper'

class DiscussionTempletsControllerTest < ActionController::TestCase
  setup do
    @discussion_templet = discussion_templets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:discussion_templets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create discussion_templet" do
    assert_difference('DiscussionTemplet.count') do
      post :create, discussion_templet: { answer: @discussion_templet.answer, code: @discussion_templet.code, concept_explanation: @discussion_templet.concept_explanation, content: @discussion_templet.content, creator_type: @discussion_templet.creator_type, grade: @discussion_templet.grade, level: @discussion_templet.level, title: @discussion_templet.title, unit_concept_id: @discussion_templet.unit_concept_id, user_id: @discussion_templet.user_id }
    end

    assert_redirected_to discussion_templet_path(assigns(:discussion_templet))
  end

  test "should show discussion_templet" do
    get :show, id: @discussion_templet
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @discussion_templet
    assert_response :success
  end

  test "should update discussion_templet" do
    patch :update, id: @discussion_templet, discussion_templet: { answer: @discussion_templet.answer, code: @discussion_templet.code, concept_explanation: @discussion_templet.concept_explanation, content: @discussion_templet.content, creator_type: @discussion_templet.creator_type, grade: @discussion_templet.grade, level: @discussion_templet.level, title: @discussion_templet.title, unit_concept_id: @discussion_templet.unit_concept_id, user_id: @discussion_templet.user_id }
    assert_redirected_to discussion_templet_path(assigns(:discussion_templet))
  end

  test "should destroy discussion_templet" do
    assert_difference('DiscussionTemplet.count', -1) do
      delete :destroy, id: @discussion_templet
    end

    assert_redirected_to discussion_templets_path
  end
end
