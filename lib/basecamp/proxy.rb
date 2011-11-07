module Basecamp
  class Proxy
    instance_methods.each { |m| undef_method m unless m =~ /(^__|^send$|^object_id$)/ }
    attr_accessor :token

    def initialize(target, token = nil)
      @target = target
      if token
        self.token = token
        @target.headers.merge!(oauth_header)
      end
    end

    def oauth_header
      token.nil? ? {} : {"Authorization" => "Token token=#{token}"}
    end

    protected

    def method_missing(name, *args, &block)
      object = @target.send(name, *args, &block)
      object.token = token if [:all, :first, :last].include?(name)
      object
    end
  end
end

# $LOAD_PATH << File.join(File.dirname(__FILE__), 'lib')
# require "basecamp"
# @b = Basecamp::Connection.new({:site => "objectreload.basecamphq.com", :oauth_token => "BAhbByIBx3siZXhwaXJlc19hdCI6IjIwMTEtMTEtMThUMDg6NDY6MDhaIiwidXNlcl9pZHMiOls5MDQxNDgwLDkwNDE0NzksOTA0MTQ3OCw5MDQxNDc3XSwidmVyc2lvbiI6MSwiY2xpZW50X2lkIjoiMTY5MzMwY2M2MTE1ZjVhMDY4YzFjMGIxMDk3ZDNiN2JiMzA4MGI0ZiIsImFwaV9kZWFkYm9sdCI6IjdjNGZmMWE4ZGY5NzcxYWMxNGM5NzdiNzBiYzc4YzdjIn11OglUaW1lDUjqG8CZcI64--f48e255f020b50e31f94d502e686b67fbf5179d4"})
