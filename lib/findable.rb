
module Concerns::Findable

  def find_by_name name
    all.find do |item|
      item.name == name
    end
  end

  def find_or_create_by_name name
    find = find_by_name name
    find ? find : create(name)
  end
end
