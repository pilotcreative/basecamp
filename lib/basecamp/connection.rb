module Basecamp
  class Connection
    include ActiveModel::Conversion  
    extend ActiveModel::Naming  
    attr_accessor :site, :user, :password, :oauth_token, :use_ssl

    def initialize(attributes = {})
      Object.const_set("Connection#{object_id}", Class.new)
      attributes.each do |name, value|
        if name == :api_token
          self.user = value
          self.password = "X"
        else
          send("#{name}=", value)
        end
      end
    end

    def to_s
      "Connection#{object_id}"        
    end

    def projects
      Proxy.new(Project, self)
    end

    def people
      Proxy.new(Person, self)
    end

    def companies
      Proxy.new(Company, self)
    end

    def messages
      Proxy.new(Message, self)
    end

    def comments
      Proxy.new(Comment, self)
    end
  end
end
