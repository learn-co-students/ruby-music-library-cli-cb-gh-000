class Song 
	
	attr_accessor :name
	attr_reader :artist, :genre 
	
	@@all = []
	
	def initialize(name, artist = nil, genre = nil)
		@name = name 
		self.artist = artist if artist != nil
		artist.genres << genre if artist != nil && genre != nil && !artist.genres.include?(genre)
		genre.artists << artist if artist != nil && genre != nil && !genre.artists.include?(artist)
		self.genre = genre if genre != nil
		#self.class.all << self 
	end 
	
	def self.find_or_create_by_name(name)
		ret = self.find_by_name(name)
		if ret == nil 
			return self.create(name)
		else 
			return ret
		end 		
	end 
	
	def self.find_by_name(name)
		self.all.each do |element|
			if element.name == name 
				return element
			end 
		end 
		ret = nil
	end 
	
	def genre=(genre)
		@genre = genre
		genre.songs << self if !( genre.songs.include?(self) )
	end 
	
	def artist=(artist)
		@artist = artist
		artist.add_song(self)
	end 
	
	def self.all
		@@all 
	end
	
	def save
		self.class.all << self
	end 
	
	def self.destroy_all
		@@all.clear
	end 
	
	def self.create(name)
		new = self.new(name)
		new.save
		new 
	end 
	
	def self.new_from_filename(filename)
		filename.slice!(".mp3")
		name = filename.split(" - ")
		artist = Artist.find_or_create_by_name(name[0])
		genre = Genre.find_or_create_by_name(name[2])	
		new = self.new(name[1], artist, genre)
	end 
	
	def self.create_from_filename(filename)
		new = self.new_from_filename(filename)
		new.save
		new
	end 
	
	
	
end 

