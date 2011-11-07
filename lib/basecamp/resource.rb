module Basecamp
  class Resource < ActiveResource::Base
    attr_accessor :token
    self.format= :xml
  end
end
