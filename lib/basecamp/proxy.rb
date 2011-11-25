module Basecamp
  class Proxy
    instance_methods.each { |m| undef_method m unless m =~ /(^__|^send$|^object_id$)/ }

    def initialize(target, connection)
      element_name = target.to_s.split("::").last.downcase
      class_name = "#{element_name.classify}#{connection.object_id}"
      const = connection.to_s.constantize

      unless const.const_defined?(class_name)
        @target = const.const_set(class_name, Class.new(target))
      else
        @target = const.const_get(class_name)
      end
      @target.tap do |t|
        t.connection_attributes = connection
        t.element_name = element_name
      end
    end

    protected

    def method_missing(name, *args, &block)
      @target.send(name, *args, &block)
    end
  end
end
