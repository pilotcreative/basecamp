module Basecamp
  class Connection
    def initialize(attributes = {})
      @attributes = attributes
    end

    def projects
      Proxy.new(Project, @attributes)
    end

    def people
      Proxy.new(Person, @access_token)
    end
  end
end
