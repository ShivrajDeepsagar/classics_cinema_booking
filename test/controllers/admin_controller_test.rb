require 'test_helper'

class AdminControllerTest < ActionDispatch::IntegrationTest
  test "should get addmovies" do
    get admin_addmovies_url
    assert_response :success
  end

  test "should get addtheater" do
    get admin_addtheater_url
    assert_response :success
  end

  test "should get createscreening" do
    get admin_createscreening_url
    assert_response :success
  end

end
