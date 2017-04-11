require_relative './concerns/findable.rb'
class Artist
  attr_accessor :name, :songs

  extend Concerns::Findable
  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def self.all
    @@all.dup.freeze
  end

  def save
    @genres = []
    @@all << self
  end

  def self.create(name)
    new(name).tap { |artist| artist.save }
  end

  def self.destroy_all
    @@all.clear
  end

  def add_song(song)
    song.artist = self unless song.artist == self
    @songs << song if song.is_a?(Song) && !@songs.include?(song)
  end

  def genres
    @songs.collect { |song| song.genre }.uniq
  end

  def to_s
    self.name
  end
end
