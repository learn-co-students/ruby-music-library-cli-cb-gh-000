module Concerns
  module Findable
    def self.find_by_name(name)
      self.all.detect {|a| a.name == name}
    end

    def self.find_or_create_by_name(name)
      a = self.find_by_name(name)
      if a == nil
        a = self.create(name)
      end
      a
    end
  end
end
