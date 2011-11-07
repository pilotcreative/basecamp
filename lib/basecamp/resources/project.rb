module Basecamp
  class Project < Resource
    def messages
      Message.prefix = "/projects/#{self.id}/"
      Message
    end
  end
end
