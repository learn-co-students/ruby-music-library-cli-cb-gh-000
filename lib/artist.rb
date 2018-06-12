class Artist 
	
	attr_accessor :name, :songs
	
	extend Concerns::Findable
	
	def initialize(name)
		@name = name
		@songs = []
		@genres_list = []
	end 
	
	def genres
		@genres_list
	end 
	
	@@all = []
	
	def self.all 
		@@all
	end 
	
	def self.destroy_all
		@@all.clear
	end
	
	def save
		self.class.all << self 
	end 
	
	def self.create(name)
		new = self.new(name)
		new.save
		new
	end 
	
	def add_song(song)
		if song.artist == nil
			song.artist = self
		end 
		if !self.songs.include?(song)
			self.songs << song
		end 
	end 	

end 
