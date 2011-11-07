module Basecamp
  class Resource < ActiveResource::Base
    self.format= :xml
  end
end
