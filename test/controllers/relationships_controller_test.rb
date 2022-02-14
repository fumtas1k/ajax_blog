require 'test_helper'

class RelationshipsControllerTest < ActionDispatch::IntegrationTest
  test "should get rails" do
    get relationships_rails_url
    assert_response :success
  end

  test "should get c" do
    get relationships_c_url
    assert_response :success
  end

end
