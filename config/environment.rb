require 'bundler'
Bundler.require

module Concerns
  module Findable
    def find_by_name(name)
      self.all.detect do |obj|
        obj.name == name
      end
    end

    def find_or_create_by_name(name)
      obj = self.find_by_name(name)
      if !obj
        obj = self.create(name)
      end
      obj
    end
  end
end

require_all 'lib'
