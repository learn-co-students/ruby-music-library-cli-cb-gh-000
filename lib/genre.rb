require 'concerns'

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
    @@all = []
  end

  def save
    @@all << self
  end


  def self.create(name)
    genre = Genre.new(name)
    genre.save
    return genre
  end

  def artists
    artists = @songs.map do |song|
      song.artist
    end
    return artists.uniq
  end
end
