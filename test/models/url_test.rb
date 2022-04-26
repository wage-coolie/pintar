require "test_helper"

class UrlTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  # test for valid url and shortcode
  test 'valid url and short_code ' do
    url = Url.new(url: 'example0.com', short_code: 'mxepcm')
    assert url.valid?
  end

  # test for invalid shortcode
  test 'shortcode should be invalid' do
    url = Url.new(url: 'example1.com', short_code: 'test')
    assert_not url.valid?
  end

end
