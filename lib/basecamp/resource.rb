module Basecamp
  class Resource < ActiveResource::Base
    cattr_reader :connection_attributes

    def self.connection_attributes=(connection)
      use_ssl = connection.use_ssl || connection.oauth_token
      self.format = :xml
      self.site = "#{use_ssl ? "https" : "http"}://#{connection.site}"
      self.user = connection.user
      self.password = connection.password
      self.headers.merge!({"Authorization" => "Token token=#{connection.oauth_token}"}) if connection.oauth_token
      @@connection_attributes = connection
    end
  end
end