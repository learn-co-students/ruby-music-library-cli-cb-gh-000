require 'pry'

class Song

  extend Concerns::Memorable::ClassMethods
  include Concerns::Memorable::InstanceMethods
  extend Concerns::Findable

  @@all = []

  def self.all
    @@all
  end

  # Makes a new Song with existent or new Artist and Genre, but does not Save each of them.
  def self.new_from_filename(filename)
    artist, name, genre = filename.split(/(?: - |\.mp3)/)   #NOTE:  filename.chomp(".mp3").split(" - ") could also have worked.
    artist = Artist.find_by_name(artist) || Artist.new(artist)
    genre = Genre.find_by_name(genre) || Genre.new(genre)
    song = self.new(name, artist, genre)
    song
  end

  def self.create_from_filename(filename)
    song = self.new_from_filename(filename)
    song.save
    song.artist.save
    song.genre.save
    song
  end


  attr_accessor :name
  attr_reader :artist, :genre

  def initialize(name, artist = nil, genre = nil)
    super(name)
    artist.add_song(self) if artist
    genre.add_song(self) if genre
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.add_song(self)
  end

  def to_s
    "#{self.artist.name} - #{self.name} - #{self.genre.name}"
  end

end
