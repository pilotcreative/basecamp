module Basecamp
  class Proxy
    instance_methods.each { |m| undef_method m unless m =~ /(^__|^send$|^object_id$)/ }

    def initialize(target, connection)
      element_name = target.to_s.split("::").last.downcase
      @target = Class.new(target).tap do |t|
        t.element_name = element_name
        t.connection_attributes = connection
      end
    end

    protected

    def method_missing(name, *args, &block)
      @target.send(name, *args, &block)
    end
  end
end
