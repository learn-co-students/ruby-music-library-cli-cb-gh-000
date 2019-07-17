require 'pry'
class Song

  @@all = []
  attr_accessor :name
  attr_reader :artist, :genre

  def initialize(name, artist=nil, genre=nil)
    @name = name
    if artist != nil
      self.artist = artist
    end
    if genre != nil
      self.genre = genre
    end
  end

  def self.new_from_filename(filename)
    arr = filename.split(" - ")
    song_name = arr[1]
    artist_name = arr[0]
    genre_name = File.basename(arr[2], ".*")

    artist = Artist.find_or_create_by_name(artist_name)
    genre = Genre.find_or_create_by_name(genre_name)
    song = Song.new(song_name, artist, genre)
    song
  end

  def self.create_from_filename(filename)
    song = self.new_from_filename(filename)
    song.save
    song
  end

  def artist=(artist)
    if self.artist!=artist
      @artist = artist
      artist.add_song(self)
    end
  end

  def genre=(genre)
    if self.genre!=genre
      @genre = genre
      genre.add_song(self)
    end
  end

  def save
    self.class.all << self
  end

  def self.create(name)
    song = Song.new(name)
    song.save
    song
  end

  def self.all
    @@all
  end

  def self.destroy_all
    self.all.clear
  end

  def self.find_by_name(name)
    self.all.detect do |song|
      song.name == name
    end
  end

  def self.find_or_create_by_name(name)
    if !self.find_by_name(name)
      self.create(name)
    else
      self.find_by_name(name)
    end
  end


end
