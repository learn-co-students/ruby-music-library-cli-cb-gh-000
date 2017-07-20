require 'bundler'
Bundler.require

module Concerns

  module Findable
    def find_by_name(name)
      self.all.each do |item|
        return item if item.name == name
      end
      nil
    end

    def find_or_create_by_name(name)
      item = self.find_by_name(name)
      return item unless item == nil
      self.create(name)
    end
  end

end

require_all 'lib'
