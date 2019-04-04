class Genre
	extend Concerns::Findable
	attr_accessor :name, :song, :artist
	def initialize(name, song=nil, artist=nil)
		@name = name
		@song = song
		@artist = artist
		@@all = []
		@songs = []
	end

	def songs
		@songs
	end

	def artists
		songs.collect {|s| s.artist }.uniq
	end

	def self.all
		@@all
	end

	def self.destroy_all
		@@all = []
	end

	def save
		@@all << self
	end

	def self.create(name)
		genre = new(name)
		genre.save
		genre
	end

end
