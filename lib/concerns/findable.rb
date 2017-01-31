module Concerns
  module Findable
    def find_by_name(name)
      self.all.detect do |item|
        item.name == name
      end
    end

    def find_or_create_by_name(name)
      find_result = self.find_by_name(name)
      find_result != nil ? find_result : self.create(name)
    end
  end
end
