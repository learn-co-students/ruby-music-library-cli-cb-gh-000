require_relative "concerns"
class Genre
  include Concerns

  @@all = []

  def self.all
    @@all
  end

  attr_accessor :name
  attr_reader :songs

  def initialize name
    @name = name
    @songs = []
  end

  def add_song song
    return nil if @songs.include? song
    @songs << song
    song.genre = self
  end

  def artists
    self.songs.collect{|song| song.artist}.uniq
  end
end
