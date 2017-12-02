module Concerns::Findable
  def find_by_name(name)
    self.all.find { |e| e.name == name }
  end
  def find_or_create_by_name(name)
    obj = self.find_by_name(name)
    obj ||= self.create(name)
    obj
  end
end
