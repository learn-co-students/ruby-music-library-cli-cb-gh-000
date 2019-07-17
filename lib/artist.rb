require 'pry'
require 'concerns/findable'

class Artist
  extend Concerns::Findable

  @@all = []
  attr_accessor :name, :songs, :genres

  def initialize(name)
    @name = name
    @songs = []
  end

  def self.create(name)
    artist = Artist.new(name)
    artist.save
    artist
  end

  def self.all
    @@all
  end

  def save
    self.class.all << self
  end

  def self.destroy_all
    self.all.clear
  end

  def add_song(song)
    if self.songs.empty? || !self.songs.include?(song)
      self.songs << song
      if song.artist == nil
        song.artist = self
      end
    end
  end

  def genres
    @genres = []
    self.songs.each do |song|
      @genres << song.genre
    end
    @genres.uniq
  end

end
