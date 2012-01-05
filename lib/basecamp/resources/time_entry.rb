module Basecamp
  class TimeEntry < Resource
    def todo_item
      @item = Proxy.new(TodoItem, self.connection_attributes)
      @item.element_name = "todo_item"
      @item.find(self.todo_item_id)
    end
  end
end
