require_relative "common"

class Artist < CommonObject
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
      song.artist = self unless song.artist
    end
  end

  def genres
    self.songs.map { |e| e.genre }.uniq
  end

end
