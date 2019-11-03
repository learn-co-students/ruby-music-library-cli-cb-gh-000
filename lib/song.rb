require_relative "common"
require_relative "artist"
require_relative "genre"
require "pry"

class Song < CommonObject
  @@all = []
  def self.all
    @@all
  end
  def self.destroy_all
    @@all = []
  end
  attr_reader :artist, :genre
  def initialize(name, artist = nil, genre = nil)
    super(name)
    self.artist = artist if artist
    self.genre = genre if genre
  end
  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end
  def genre=(genre)
    @genre = genre
    genre.add_song(self)
  end

  def self.new_from_filename(file_name)
    artist, song, genre = file_name
        .scan(/([\w|\s|\W]+)\s-\s([\w|\s|\W]+)\s-\s(.+)\.mp3/)
        .flatten
    # puts artist, song, genre
    # binding.pry
    artist = Artist.find_or_create_by_name(artist)
    genre = Genre.find_or_create_by_name(genre)
    self.new(song, artist, genre)
  end

  def self.create_from_filename(filename)
    song = self.new_from_filename(filename)
    song.save
    song
  end
end

# binding.pry
