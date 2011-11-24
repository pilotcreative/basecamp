module Basecamp
  class Proxy
    instance_methods.each { |m| undef_method m unless m =~ /(^__|^send$|^object_id$)/ }

    def initialize(target, connection)
      $klass = target
      element_name = $klass.to_s.split("::").last
      const = connection.to_s.constantize

      unless const.const_defined?(element_name)
        @target = const.const_set(element_name, Class.new($klass))
      else
        @target = const.const_get(element_name)
      end

      @target.connection_attributes = connection
    end

    protected

    def method_missing(name, *args, &block)
      @target.send(name, *args, &block)
    end
  end
end
