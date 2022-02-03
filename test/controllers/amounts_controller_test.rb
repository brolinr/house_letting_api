require "test_helper"

class AmountsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @amount = amounts(:one)
  end

  test "should get index" do
    get amounts_url, as: :json
    assert_response :success
  end

  test "should create amount" do
    assert_difference('Amount.count') do
      post amounts_url, params: { amount: { price: @amount.price, user_id: @amount.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show amount" do
    get amount_url(@amount), as: :json
    assert_response :success
  end

  test "should update amount" do
    patch amount_url(@amount), params: { amount: { price: @amount.price, user_id: @amount.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy amount" do
    assert_difference('Amount.count', -1) do
      delete amount_url(@amount), as: :json
    end

    assert_response 204
  end
end
