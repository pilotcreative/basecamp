module Basecamp
  class Project < Resource
    def messages
      @message = Proxy.new(Message, self.connection_attributes)
      @message.prefix = "/projects/#{self.id}/"
      @message.element_name = "post"
      @message
    end

    def people
      @person = Proxy.new(Person, self.connection_attributes)
      @person.prefix = "/projects/#{self.id}/"
      @person
    end

    def attachments
      @attachment = Proxy.new(Attachment, self.connection_attributes)
      @attachment.prefix = "/projects/#{self.id}/"
      @attachment
    end

    def time_entries
      @entry = Proxy.new(TimeEntry, self.connection_attributes)
      @entry.prefix = "/projects/#{self.id}/"
      @entry.element_name = "time_entry"
      @entry
    end
  end
end
