module Concerns::Findable
	def find_by_name(name)
		all.detect {|thing| thing.name == name}
	end

	def find_or_create_by_name(name)
		thing = find_by_name(name) ? find_by_name(name) : create(name)
		thing
	end
end
