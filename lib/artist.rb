require 'concerns'

class Artist

  extend Concerns::Findable

  attr_accessor :name
  attr_reader :songs

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def add_song(song)
    if(song.artist == nil)
      song.artist = self
    end

    if(!songs.include?(song))
      songs << song
    end
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all = []
  end

  def save
    @@all << self
  end

  def genres
    genres = songs.map do |song|
      song.genre
    end
    return genres.uniq
  end

  def self.create(name)
    artist = Artist.new(name)
    artist.save
    return artist
  end
end
