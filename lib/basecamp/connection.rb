module Basecamp
  class Connection
    include ActiveModel::Conversion  
    extend ActiveModel::Naming  
    attr_accessor :site, :user, :password, :oauth_token, :use_ssl

    def initialize(attributes = {})
      attributes.each do |name, value|  
        send("#{name}=", value)  
      end  
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
  end
end
