module Basecamp
  class Proxy
    instance_methods.each { |m| undef_method m unless m =~ /(^__|^send$|^object_id$)/ }

    def initialize(target, attributes)
      element_name = target.to_s.split("::").last.downcase
      use_ssl = attributes[:use_ssl] || attributes[:oauth_token]
      site = "#{use_ssl ? "https" : "http"}://#{attributes[:site]}"
      @target = Class.new(target).tap do |t|
        t.format = :xml
        t.element_name = element_name
        t.site = site
        t.user = attributes[:user]
        t.password = attributes[:password]
        # target.headers.merge!({"Authorization" => "Token token=#{token}"}) if attributes[:oauth_token]
      end
    end

    protected

    def method_missing(name, *args, &block)
      @target.send(name, *args, &block)
    end
  end
end
