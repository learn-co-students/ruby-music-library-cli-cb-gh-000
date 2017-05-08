require_relative '../config/environment.rb'

class Artist
  extend Concerns::Findable
  
  attr_accessor :name, :songs

  @@all = []
  @songs = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def save
    self.class.all << self
    self
  end

  def add_song(song)
    @songs << song unless @songs.include?(song)
    song.artist = self if song.artist == nil
  end

  def genres
    songs.map { |song| song.genre }.uniq
  end

  def self.create(name)
    self.new(name).save
  end

  def self.all
    @@all
  end

  def self.destroy_all
    all.clear
  end

end
