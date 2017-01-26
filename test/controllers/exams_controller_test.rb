require 'test_helper'

class ExamsControllerTest < ActionController::TestCase
  setup do
    @exam = exams(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:exams)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create exam" do
    assert_difference('Exam.count') do
      post :create, exam: { contents: @exam.contents, exam_type: @exam.exam_type, month: @exam.month, number: @exam.number, score: @exam.score, year: @exam.year }
    end

    assert_redirected_to exam_path(assigns(:exam))
  end

  test "should show exam" do
    get :show, id: @exam
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @exam
    assert_response :success
  end

  test "should update exam" do
    patch :update, id: @exam, exam: { contents: @exam.contents, exam_type: @exam.exam_type, month: @exam.month, number: @exam.number, score: @exam.score, year: @exam.year }
    assert_redirected_to exam_path(assigns(:exam))
  end

  test "should destroy exam" do
    assert_difference('Exam.count', -1) do
      delete :destroy, id: @exam
    end

    assert_redirected_to exams_path
  end
end
