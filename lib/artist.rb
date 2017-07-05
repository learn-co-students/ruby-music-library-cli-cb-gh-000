require_relative '../lib/concerns/findable'

class Artist
  extend Concerns::Findable
  attr_accessor :name, :songs

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def self.create(name)
    new(name).tap{|a| a.save}
  end

  def self.all
    @@all
  end

  def add_song(song)
    unless @songs.include?(song)
      @songs << song
    end

    unless song.artist == self
      song.artist = self
    end
  end

  def self.destroy_all
    @@all.clear
  end

  def save
    @@all << self
  end

  def genres
    self.songs.collect{|s| s.genre}.uniq
  end

  def to_s
    self.name
  end
end
