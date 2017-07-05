require 'bundler'
Bundler.require

module Concerns
  module Findable
    def find_by_name(name)
      self.all.detect{|entity| entity.name == name}
    end
    def find_or_create_by_name(name)
      entity = find_by_name(name)
      if entity.nil?
        entity = self.create(name)
      end
      entity
    end
  end
end

require_all 'lib'