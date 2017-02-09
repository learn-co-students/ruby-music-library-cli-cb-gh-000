module Concerns
  module Findable
    def find_by_name(name)
      self.all.detect{|o| o.name}
    end

    def find_or_create_by_name(name)
      if self.all.detect{|o| o.name}
        self.all.detect{|o| o.name}
      else
        self.create(name)
      end
    end

  end
end