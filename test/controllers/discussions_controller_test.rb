require 'test_helper'

class DiscussionsControllerTest < ActionController::TestCase
  setup do
    @discussion = discussions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:discussions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create discussion" do
    assert_difference('Discussion.count') do
      post :create, discussion: { answer: @discussion.answer, content: @discussion.content, core_unit_concept: @discussion.core_unit_concept, expiration_date: @discussion.expiration_date, final_report: @discussion.final_report, grade: @discussion.grade, interim_report: @discussion.interim_report, leader: @discussion.leader, manage_type: @discussion.manage_type, observer_yn: @discussion.observer_yn, organizer: @discussion.organizer, participant_id: @discussion.participant_id, related_unit_concept: @discussion.related_unit_concept, title: @discussion.title, title_explanation: @discussion.title_explanation }
    end

    assert_redirected_to discussion_path(assigns(:discussion))
  end

  test "should show discussion" do
    get :show, id: @discussion
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @discussion
    assert_response :success
  end

  test "should update discussion" do
    patch :update, id: @discussion, discussion: { answer: @discussion.answer, content: @discussion.content, core_unit_concept: @discussion.core_unit_concept, expiration_date: @discussion.expiration_date, final_report: @discussion.final_report, grade: @discussion.grade, interim_report: @discussion.interim_report, leader: @discussion.leader, manage_type: @discussion.manage_type, observer_yn: @discussion.observer_yn, organizer: @discussion.organizer, participant_id: @discussion.participant_id, related_unit_concept: @discussion.related_unit_concept, title: @discussion.title, title_explanation: @discussion.title_explanation }
    assert_redirected_to discussion_path(assigns(:discussion))
  end

  test "should destroy discussion" do
    assert_difference('Discussion.count', -1) do
      delete :destroy, id: @discussion
    end

    assert_redirected_to discussions_path
  end
end
