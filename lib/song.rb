require_relative '../config/environment.rb'

class Song
  attr_accessor :name
  attr_reader :artist, :genre

  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist unless artist == nil
    self.genre = genre unless genre == nil
  end

  def save
    self.class.all << self
    self
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.add_song(self)
  end

  def self.create(name, artist=nil, genre = nil)
    self.new(name, artist, genre).save
  end

  def self.new_from_filename(filename)
    artist_name, song_name, genre_name = filename.split(" - ")
    genre_name = genre_name.chomp(".mp3")

    artist = Artist.find_or_create_by_name(artist_name)
    genre = Genre.find_or_create_by_name(genre_name)

    self.new(song_name, artist, genre)
  end

  def self.create_from_filename(filename)
    self.new_from_filename(filename).save
  end

  def self.all
    @@all
  end

  def self.destroy_all
    all.clear
  end

  def self.find_by_name(name)
    all.find { |song| song.name == name }
  end

  def self.find_or_create_by_name(name)
    self.find_by_name(name) || self.create(name)
  end

end
