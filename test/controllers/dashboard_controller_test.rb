require 'test_helper'

class DashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get dataload" do
    get dashboard_dataload_url
    assert_response :success
  end

  test "should get visualisations" do
    get dashboard_visualisations_url
    assert_response :success
  end

end
