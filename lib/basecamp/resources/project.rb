module Basecamp
  class Project < Resource
    def messages
      @message = Proxy.new(Message, self.connection_attributes)
      @message.prefix = "/projects/#{self.id}/"
      @message.element_name = "post"
      @message
    end
  end
end
