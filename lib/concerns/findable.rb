module Concerns::Findable

	def find_by_name(name)
		self.all.each do |element|
			if element.name == name 
				return element
			end 
		end 
		ret = nil
	end 
	
	def find_or_create_by_name(name)
		ret = self.find_by_name(name)
		if ret == nil 
			return self.create(name)
		else 
			return ret
		end 		
	end 

end 
