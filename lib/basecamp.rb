require "net/http"
require "active_resource"

require "basecamp/version"

require "basecamp/proxy"
require "basecamp/resource"
require "basecamp/resources/attachment"
require "basecamp/resources/company"
require "basecamp/resources/person"
require "basecamp/resources/project"
require "basecamp/resources/comment"
require "basecamp/resources/message"

require "basecamp/connection"


class ActiveResource::Connection
  cattr_accessor :requests
  def http
    @@requests ||= 0
    throttle if @@requests >= 500
    http = Net::HTTP.new(@site.host, @site.port)
    http.use_ssl = @site.is_a?(URI::HTTPS)
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE if http.use_ssl?
    http.read_timeout = @timeout if @timeout
    @@requests += 1
    http
  end
private
  def throttle
    sleep 10
    @@requests = 0
  end
end