require 'test_helper'

class BlogRepliesControllerTest < ActionController::TestCase
  setup do
    @blog_reply = blog_replies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:blog_replies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create blog_reply" do
    assert_difference('BlogReply.count') do
      post :create, blog_reply: { blog_id: @blog_reply.blog_id, comment: @blog_reply.comment, depth: @blog_reply.depth, group_id: @blog_reply.group_id, order_no: @blog_reply.order_no, parent_reply_id: @blog_reply.parent_reply_id, user_id: @blog_reply.user_id }
    end

    assert_redirected_to blog_reply_path(assigns(:blog_reply))
  end

  test "should show blog_reply" do
    get :show, id: @blog_reply
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @blog_reply
    assert_response :success
  end

  test "should update blog_reply" do
    patch :update, id: @blog_reply, blog_reply: { blog_id: @blog_reply.blog_id, comment: @blog_reply.comment, depth: @blog_reply.depth, group_id: @blog_reply.group_id, order_no: @blog_reply.order_no, parent_reply_id: @blog_reply.parent_reply_id, user_id: @blog_reply.user_id }
    assert_redirected_to blog_reply_path(assigns(:blog_reply))
  end

  test "should destroy blog_reply" do
    assert_difference('BlogReply.count', -1) do
      delete :destroy, id: @blog_reply
    end

    assert_redirected_to blog_replies_path
  end
end
