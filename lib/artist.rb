require_relative "findable.rb"

class Artist

  @@all = []

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def self.create(name)
    artist = self.new(name)
    artist.save
    artist
  end

  extend Concerns::Findable

  attr_accessor :name, :songs

  def initialize(name)
    @name = name
    @songs = []
  end

  def add_song(song)
    @songs << song if ! @songs.include? song
    song.artist = self if song.artist == nil
  end

  def save
    @@all << self
  end

  def genres
    @songs.map { |song| song.genre }.uniq
  end

end
