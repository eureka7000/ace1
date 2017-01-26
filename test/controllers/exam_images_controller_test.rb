require 'test_helper'

class ExamImagesControllerTest < ActionController::TestCase
  setup do
    @exam_image = exam_images(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:exam_images)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create exam_image" do
    assert_difference('ExamImage.count') do
      post :create, exam_image: { filename: @exam_image.filename, height: @exam_image.height, width: @exam_image.width }
    end

    assert_redirected_to exam_image_path(assigns(:exam_image))
  end

  test "should show exam_image" do
    get :show, id: @exam_image
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @exam_image
    assert_response :success
  end

  test "should update exam_image" do
    patch :update, id: @exam_image, exam_image: { filename: @exam_image.filename, height: @exam_image.height, width: @exam_image.width }
    assert_redirected_to exam_image_path(assigns(:exam_image))
  end

  test "should destroy exam_image" do
    assert_difference('ExamImage.count', -1) do
      delete :destroy, id: @exam_image
    end

    assert_redirected_to exam_images_path
  end
end
