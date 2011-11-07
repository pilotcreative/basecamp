module Basecamp
  class Message < Resource
    self.element_name = "post"

    def comment
      Comment.prefix = "/posts/#{id}/"
      Comment
    end
  end
end
