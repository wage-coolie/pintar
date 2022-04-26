require "test_helper"

class UrlShortnerControllerTest < ActionDispatch::IntegrationTest
	setup do
		@url = urls(:one)
	end
	test "should show location of the mapped shortcode" do
		get '/mxepcm', as: :json
		json_response = JSON.parse(self.response.body)
		assert_equal @url.url, json_response['Location']
	end

end
