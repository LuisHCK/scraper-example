require 'test_helper'

class Api::V1::PagesControllerTest < ActionDispatch::IntegrationTest
  test "url can be scraped" do
    post "/api/v1/pages", params: {
      url: "https://medium.com/tag/vuejs"
    }
    assert_response :success
  end

  test "can get scraped pages" do
    get "/api/v1/pages"
    assert_response :success
  end
end
