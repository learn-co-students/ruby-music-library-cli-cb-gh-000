require_relative '../config/environment.rb'

class Genre
  extend Concerns::Findable
  attr_accessor :name, :songs

  @@all = []

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
  end

  def artists
    @songs.map { |song| song.artist }.uniq
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
