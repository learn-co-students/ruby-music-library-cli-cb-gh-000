
require_relative 'concerns/concerns'

class Genre
  attr_accessor :name, :songs
  @@all = []
  extend Concerns::Findable
  
  def initialize(name)
    @name = name
    @songs = []
  end

  def self.all
    @@all
  end

  def save
    @@all << self
  end

  def self.destroy_all
    @@all = []
  end

  def self.create(name)
    new(name).tap{|o| o.save}
  end
  
  def artists
    @songs.collect{|s| s.artist}.uniq
  end

  def to_s
    @name
  end

end