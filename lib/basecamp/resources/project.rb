module Basecamp
  class Project < Resource
    def messages
      @message = Proxy.new(Message, self.token)
      @message.prefix = "/projects/#{self.id}/"
      @message
    end
  end
end
