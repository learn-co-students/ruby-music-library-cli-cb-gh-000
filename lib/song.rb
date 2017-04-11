require_relative './concerns/findable.rb'

class Song
  attr_accessor :name, :artist, :genre

  extend Concerns::Findable

  @@all = []

  def initialize(name, artist=nil, genre=nil)
    @name = name
    self.artist = artist if artist
    self.genre = genre if genre
  end

  def self.new_from_filename(filename)
    artist, name, genre = filename.split(' - ')
    artist = Artist.find_or_create_by_name(artist)
    genre = genre.split('.').first
    genre = Genre.find_or_create_by_name(genre)
    new(name, artist, genre)
  end

  def self.create_from_filename(filename)
    new_from_filename(filename).tap { |song| song.save }
  end

  def self.all
    @@all.dup.freeze
  end

  def self.destroy_all
    @@all.clear
  end

  def save
    @@all << self
  end

  def self.create(name, artist=nil, genre=nil)
    new(name, artist, genre).tap {|song| song.save }
  end

  def artist=(artist)
    @artist = artist unless @artist == artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre unless @genre == genre
    genre.add_song(self)
  end

  def to_s
    "#{self.artist.name} - #{self.name} - #{self.genre.name}"
  end
end
