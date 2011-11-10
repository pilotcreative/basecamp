module Basecamp
  class Message < ActiveResource::Base
    self.element_name = "post"

    def comment
      Comment.prefix = "/posts/#{id}/"
      Comment
    end
  end
end
