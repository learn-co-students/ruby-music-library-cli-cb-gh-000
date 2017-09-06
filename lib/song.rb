class Song

	attr_accessor :name
	attr_reader :artist, :genre

	extend Concerns::Findable

	@@all = []

	def initialize(name, artist = nil, genre = nil)
		@name = name
		self.artist = artist unless !artist
		self.genre = genre unless !genre
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
		song = new(name)
		song.save
		song
	end

	def artist=(artist)
		@artist = artist
		artist.add_song(self)
	end

	def genre=(genre)
		@genre = genre
		genre.add_song(self)
	end

	def self.new_from_filename(filename)
		song = new(filename.split("-")[1].strip)
		artist = Artist.find_or_create_by_name(filename.split("-")[0].strip)
		genre = Genre.find_or_create_by_name(filename.split("-")[2..5].join("-").split('.')[0].strip)
		artist.songs << self
		song.artist = artist
		song.genre = genre
		song
	end

	def self.create_from_filename(filename)
		song = new_from_filename(filename)
		song.save
	end

end
