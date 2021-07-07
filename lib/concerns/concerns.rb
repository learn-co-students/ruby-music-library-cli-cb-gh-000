
module Concerns
  module Findable
    def find_by_name(name)
      self.all.find {|instance| instance.name == name}
    end

    def find_or_create_by_name(name)
      song = self.find_by_name(name)
      if song == nil
        song = self.create(name)
      end
      song
    end

  end

end
