require_relative "concerns"
class Artist
  include Concerns

  @@all = []

  def self.all
    @@all
  end

  attr_accessor :name
  attr_reader :songs, :artist

  def initialize name
    @name = name
    @songs = []
  end

  def add_song song
    return nil if @songs.include? song
    @songs << song
    song.artist = self
  end

  def genres
    self.songs.collect{|song| song.genre}.uniq
  end
end
