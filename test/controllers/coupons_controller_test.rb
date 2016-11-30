require 'test_helper'

class CouponsControllerTest < ActionController::TestCase
  setup do
    @coupon = coupons(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:coupons)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create coupon" do
    assert_difference('Coupon.count') do
      post :create, coupon: { coupon_code: @coupon.coupon_code, effective_period: @coupon.effective_period, effective_period_type: @coupon.effective_period_type, expire_from: @coupon.expire_from, expire_to: @coupon.expire_to, issued_reason: @coupon.issued_reason, user_id: @coupon.user_id }
    end

    assert_redirected_to coupon_path(assigns(:coupon))
  end

  test "should show coupon" do
    get :show, id: @coupon
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @coupon
    assert_response :success
  end

  test "should update coupon" do
    patch :update, id: @coupon, coupon: { coupon_code: @coupon.coupon_code, effective_period: @coupon.effective_period, effective_period_type: @coupon.effective_period_type, expire_from: @coupon.expire_from, expire_to: @coupon.expire_to, issued_reason: @coupon.issued_reason, user_id: @coupon.user_id }
    assert_redirected_to coupon_path(assigns(:coupon))
  end

  test "should destroy coupon" do
    assert_difference('Coupon.count', -1) do
      delete :destroy, id: @coupon
    end

    assert_redirected_to coupons_path
  end
end
