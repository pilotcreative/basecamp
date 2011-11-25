module Basecamp
  class Company < Resource
    def people
      @people = Proxy.new(Person, self.connection_attributes)
      @people.prefix = "/companies/#{self.id}/"
      @people
    end
  end
end
