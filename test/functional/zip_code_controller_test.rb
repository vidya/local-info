require 'test_helper'

class ZipCodeControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get nearby_zip_codes" do
    get :nearby_zip_codes
    assert_response :success
  end

end
