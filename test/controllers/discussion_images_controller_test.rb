require 'test_helper'

class DiscussionImagesControllerTest < ActionController::TestCase
  setup do
    @discussion_image = discussion_images(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:discussion_images)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create discussion_image" do
    assert_difference('DiscussionImage.count') do
      post :create, discussion_image: { discussion_id: @discussion_image.discussion_id, filename: @discussion_image.filename, height: @discussion_image.height, width: @discussion_image.width }
    end

    assert_redirected_to discussion_image_path(assigns(:discussion_image))
  end

  test "should show discussion_image" do
    get :show, id: @discussion_image
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @discussion_image
    assert_response :success
  end

  test "should update discussion_image" do
    patch :update, id: @discussion_image, discussion_image: { discussion_id: @discussion_image.discussion_id, filename: @discussion_image.filename, height: @discussion_image.height, width: @discussion_image.width }
    assert_redirected_to discussion_image_path(assigns(:discussion_image))
  end

  test "should destroy discussion_image" do
    assert_difference('DiscussionImage.count', -1) do
      delete :destroy, id: @discussion_image
    end

    assert_redirected_to discussion_images_path
  end
end
