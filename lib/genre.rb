class Genre
  @@all = []
  attr_accessor :name
  attr_reader :songs

  extend Concerns::Findable
  extend Concerns::ClassMethods
  include Concerns::InstanceMethods
  def initialize(name)
    self.name = name
    @songs = []
  end

  def self.all
    @@all
  end

  def add_song(song)
    self.songs << song if !self.songs.include?(song)
    song.genre = self if song.genre == nil
  end

  def artists
    self.songs.map {|s| s.artist}.uniq
  end

end
