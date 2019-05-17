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
      element = self.find_by_name(name)

      if !element
        element = self.create(name)
      end

      return element
    end

  end

end


require_all 'lib'
