require "test_helper"

class CurriculaControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get curricula_index_url
    assert_response :success
  end
end
