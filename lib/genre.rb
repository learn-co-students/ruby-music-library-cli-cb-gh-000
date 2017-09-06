class Genre

	attr_accessor :name, :songs
	extend Concerns::Findable

	@@all = []
	def initialize(name)
		@name = name
		@songs = []
	end

	def self.all
		@@all
	end

	def self.destroy_all
		@@all.clear
	end

	def save
		@@all << self
	end

	def self.create(name)
		genre = new(name)
		genre.save
		genre
	end

	def add_song(song)
		@songs << song unless @songs.include?(song)
		song.artist = self if !song.artist
	end

	def artists
		@songs.collect {|song| song.artist }.uniq
	end

end
