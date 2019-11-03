require_relative "common"

class Genre < CommonObject
  @@all = []
  def self.all
    @@all
  end
  def self.destroy_all
    @@all = []
  end
  attr_reader :songs
  def initialize(name)
    super(name)
    @songs = []
  end

  def add_song(song)
    unless @songs.include?(song)
      @songs << song
      song.genre = self unless song.genre
    end
  end
  def artists
    self.songs.map { |e| e.artist }.uniq
  end

end
