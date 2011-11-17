module Basecamp
  class Message < Resource
    def comments
      @comments = Proxy.new(Comment, self.connection_attributes)
      @comments.prefix = "/posts/#{self.id}/"
      @comments
    end
  end
end