class Song
  @@all = []
  attr_accessor :name
  attr_reader :artist, :genre

  extend Concerns::Findable
  extend Concerns::ClassMethods
  include Concerns::InstanceMethods

  def initialize (name, artist = nil, genre = nil)
    self.name = name
    self.artist = artist if artist
    self.genre = genre if genre
  end

  def self.all
    @@all
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
    normalize = filename.split(" - ")
    artist = Artist.find_or_create_by_name(normalize[0])
    song = self.new(normalize[1])
    genre = Genre.find_or_create_by_name(normalize[2].gsub(".mp3", ""))
    song.artist = artist
    song.genre = genre
    song
  end

  def self.create_from_filename(filename)
    normalize = filename.split(" - ")
    artist = Artist.find_or_create_by_name(normalize[0])
    song = self.create(normalize[1])
    genre = Genre.find_or_create_by_name(normalize[2].gsub(".mp3", ""))
    song.artist = artist
    song.genre = genre
    song
  end


end
