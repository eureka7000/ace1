require 'test_helper'

class InicisPaymentsControllerTest < ActionController::TestCase
  setup do
    @inicis_payment = inicis_payments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:inicis_payments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create inicis_payment" do
    assert_difference('InicisPayment.count') do
      post :create, inicis_payment: { : @inicis_payment., buyer_email: @inicis_payment.buyer_email, buyer_name: @inicis_payment.buyer_name, buyer_tel: @inicis_payment.buyer_tel, currency: @inicis_payment.currency, go_pay_method: @inicis_payment.go_pay_method, good_name: @inicis_payment.good_name, m_key: @inicis_payment.m_key, mid: @inicis_payment.mid, offer_period: @inicis_payment.offer_period, oid: @inicis_payment.oid, parent_email: @inicis_payment.parent_email, price: @inicis_payment.price, return_url: @inicis_payment.return_url, signature: @inicis_payment.signature, tax: @inicis_payment.tax, tax_free: @inicis_payment.tax_free, timestamp: @inicis_payment.timestamp, version: @inicis_payment.version }
    end

    assert_redirected_to inicis_payment_path(assigns(:inicis_payment))
  end

  test "should show inicis_payment" do
    get :show, id: @inicis_payment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @inicis_payment
    assert_response :success
  end

  test "should update inicis_payment" do
    patch :update, id: @inicis_payment, inicis_payment: { : @inicis_payment., buyer_email: @inicis_payment.buyer_email, buyer_name: @inicis_payment.buyer_name, buyer_tel: @inicis_payment.buyer_tel, currency: @inicis_payment.currency, go_pay_method: @inicis_payment.go_pay_method, good_name: @inicis_payment.good_name, m_key: @inicis_payment.m_key, mid: @inicis_payment.mid, offer_period: @inicis_payment.offer_period, oid: @inicis_payment.oid, parent_email: @inicis_payment.parent_email, price: @inicis_payment.price, return_url: @inicis_payment.return_url, signature: @inicis_payment.signature, tax: @inicis_payment.tax, tax_free: @inicis_payment.tax_free, timestamp: @inicis_payment.timestamp, version: @inicis_payment.version }
    assert_redirected_to inicis_payment_path(assigns(:inicis_payment))
  end

  test "should destroy inicis_payment" do
    assert_difference('InicisPayment.count', -1) do
      delete :destroy, id: @inicis_payment
    end

    assert_redirected_to inicis_payments_path
  end
end
