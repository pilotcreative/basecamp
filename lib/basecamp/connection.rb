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

      [:comment, :person, :message, :project].each {|resource| "Basecamp::#{resource.to_s.classify}".constantize.headers.merge!("Authorization" => "Token token=#{@access_token}") } if use_oauth?
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
      Project
    end

    def people
      Person
    end
  end
end
