require 'test_helper'

class MovieBookingControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get bookings_home_url
    assert_response :success
  end

end
