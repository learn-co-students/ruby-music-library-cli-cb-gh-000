

class Artist
  extend Memorable::ClassMethods, Concerns::Findable
  include Memorable::InstanceMethods

  attr_accessor :name, :songs
  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def add_song(song)
    if song.artist == nil
      song.artist = self
    end
    if @songs.include?(song) == false
      @songs << song
    end
  end

  def genres
    genres = []
    @songs.each{|song| genres << song.genre if genres.include?(song.genre) == false}
    genres
  end

  def self.all
    @@all
  end

end
