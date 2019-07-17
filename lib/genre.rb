require 'concerns/findable'

class Genre
  extend Concerns::Findable

  @@all = []
  attr_accessor :name, :artists, :songs

  def initialize(name)
    @name = name
    @songs = []
  end

  def self.create(name)
    genre = Genre.new(name)
    genre.save
    genre
  end

  def self.all
    @@all
  end

  def self.destroy_all
    self.all.clear
  end

  def save
    self.class.all << self
  end

  def add_song(song)
    if self.songs.empty? || !self.songs.include?(song)
      self.songs << song
    end
  end

  def artists
    @artists = []
    self.songs.each do |song|
      @artists << song.artist
    end
    @artists.uniq
  end


end
