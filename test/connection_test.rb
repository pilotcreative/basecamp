require "test_helper"
class ConnectionTest < MiniTest::Unit::TestCase
  def setup
    FakeWeb.allow_net_connect = false

    @oauth_basecamp = Basecamp::Connection.new({:site => "apple.basecamphq.com", :oauth_token => "1234567890"})
    @basic_basecamp = Basecamp::Connection.new({:site => "google.basecamphq.com", :user => "foo", :password => "bar"})
    @token_basecamp = Basecamp::Connection.new({:site => "mysite.basecamphq.com", :api_token => "0987654321", :use_ssl => true})
  end

  def test_do_not_change_headers_globally
    assert_equal({}, Basecamp::Project.headers)
    assert_equal({}, @basic_basecamp.projects.headers)
    assert_equal({"Authorization" => "Token token=1234567890"}, @oauth_basecamp.projects.headers)
  end

  def test_do_not_set_attributes_globally
    assert Basecamp::Project.site.nil?
    assert Basecamp::Project.user.nil?
    assert Basecamp::Project.password.nil?

    assert_equal "https://apple.basecamphq.com", @oauth_basecamp.projects.site.to_s
    assert @oauth_basecamp.projects.user.nil?

    assert_equal "http://google.basecamphq.com", @basic_basecamp.projects.site.to_s
    assert !@basic_basecamp.projects.user.nil?

    assert_equal "https://mysite.basecamphq.com", @token_basecamp.projects.site.to_s
    assert_equal "0987654321", @token_basecamp.projects.user
    assert_equal "X", @token_basecamp.projects.password
  end
end
