require 'pry'

class Artist

  extend Concerns::Findable

  @@all = []
  attr_accessor :name, :songs

  def initialize(name)
    @name = name
    @songs = []
  end

  def save
    @@all << self
  end

  def add_song(song)
    song.artist = self if song.artist == nil
    if !self.songs.include?(song)
      self.songs << song
    end
  end

  def genres
    @genres = []
    self.songs.each do |song|
      @genres << song.genre unless @genres.include?(song.genre)
    end
    @genres
  end

  def self.create(name)
    artist = self.new(name)
    artist.save
    artist
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

end
