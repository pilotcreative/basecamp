module Basecamp
  class Connection
    def initialize(attributes = {})
      if attributes[:oauth_token]
        @use_ssl = true
        @use_oauth = true
        @access_token = attributes[:oauth_token]
      else
        @use_ssl = attributes[:use_ssl]
        Resource.user = attributes[:user]
        Resource.password = attributes[:password]
      end

      @site = attributes[:site]
      Resource.site = "#{use_ssl? ? "https" : "http"}://#{@site}"
    end

    def use_oauth?
      @use_oauth == true
    end

    def use_ssl?
      @use_ssl == true
    end

    def projects
      Proxy.new(Project, @access_token)
    end

    def people
      Proxy.new(Person, @access_token)
    end
  end
end
