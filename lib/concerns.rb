module Concerns::Findable
  def find_by_name(name)
    cl = self.all.select do |stuff|
      stuff.name == name
    end

    return cl[0]
  end

  def find_or_create_by_name(name)
    cl = self.find_by_name(name)

    if(cl == nil)
      cl = self.create(name)
    end
    return cl
  end
end
