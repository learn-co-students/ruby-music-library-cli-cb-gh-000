module Concerns

  module Findable
    def find_by_name(name)
      self.all.each do |instance|
        return instance if instance.name == name
      end

      nil
    end

    def find_or_create_by_name(name)
      return find_by_name(name) unless find_by_name(name).nil?

      self.create(name)
    end
  end

end
