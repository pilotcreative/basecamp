require "test_helper"

class ConnectionTest < MiniTest::Unit::TestCase
  def setup
    @oauth_basecamp = Basecamp::Connection.new({:site => "site.basecamphq.com", :oauth_token => "1234567890"})
    @basic_basecamp = Basecamp::Connection.new({:site => "site.basecamphq.com", :user => "foo", :password => "bar"})
    @token_basecamp = Basecamp::Connection.new({:site => "site.basecamphq.com", :api_token => "0987654321", :use_ssl => true})
  end

  def test_do_not_change_headers_globally
    assert_equal({}, Basecamp::Project.headers)
    assert_not_equal({}, @oauth_basecamp.projects.headers)
  end

  def test_require_ssl_in_oauth
    assert @oauth_basecamp.use_ssl?
  end

  def test_do_not_require_ssl_in_other_connection_options
    assert !@basic_basecamp.use_ssl?
  end
end