class Artist
	extend Concerns::Findable
	attr_accessor :name, :song, :genre
	def initialize(name, song=nil, genre=nil)
		@name = name
		@song = song
		@genre = genre
		@@all = []
		@songs = []
	end

	def songs
		@songs
	end

	def add_song(song)
		song.artist = self unless song.artist
		@songs << song unless @songs.include?(song)
	end

	def self.all
		@@all
	end

	def genres
		songs.collect {|s| s.genre }.uniq
	end

	def self.destroy_all
		@@all = []
	end

	def save
		@@all << self
	end

	def self.create(name)
		artist = new(name)
		artist.save
		artist
	end

end
