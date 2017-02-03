require_relative "findable.rb"

class Genre

  @@all = []

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def self.create(name)
    genre = self.new name
    genre.save
    genre
  end

  extend Concerns::Findable

  attr_accessor :name, :songs

  def initialize(name)
    @name = name
    @songs = []
  end

  def add_song(song)
    @songs << song if ! @songs.include? song
    song.genre = self if song.genre == nil
  end

  def save
    @@all << self
  end

  def artists
    @songs.map { |song| song.artist }.uniq
  end

end
