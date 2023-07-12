require "test_helper"

class ParticipantsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get participants_index_url
    assert_response :success
  end

  test "should get new" do
    get participants_new_url
    assert_response :success
  end

  test "should get create" do
    get participants_create_url
    assert_response :success
  end
end
