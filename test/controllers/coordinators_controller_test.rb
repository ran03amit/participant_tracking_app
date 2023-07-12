require "test_helper"

class CoordinatorsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get coordinators_index_url
    assert_response :success
  end

  test "should get new" do
    get coordinators_new_url
    assert_response :success
  end

  test "should get create" do
    get coordinators_create_url
    assert_response :success
  end
end
