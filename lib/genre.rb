require_relative '../lib/concerns/findable'

class Genre
  extend Concerns::Findable
  attr_accessor :name
  attr_reader :songs

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def save
    @@all << self
  end

  def self.create(name)
    new(name).tap{|a| a.save}
  end

  def artists
    self.songs.collect{|s| s.artist}.uniq
  end

  def to_s
    self.name
  end

end
