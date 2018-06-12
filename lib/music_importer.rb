require 'pry'
class MusicImporter 

	attr_accessor :path, :files 
	
	def initialize(path)
		@path = path 	
		p = path+"/*.mp3"
		self.files = []
		Dir[p].each do |element| 
			element.slice!(path+"/") 
			self.files << element
		end 
	end 
	
	def import
		self.files.each { |filename| Song.create_from_filename(filename) }
	end

end 
