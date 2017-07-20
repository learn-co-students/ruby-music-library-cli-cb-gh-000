class Genre

  extend Concerns::Findable

  @@all = []
  attr_accessor :name, :songs

  def initialize(name)
    @name = name
    @songs = []
  end

  def save
    @@all << self
  end

  def artists
    @artists = []
    self.songs.each do |song|
      @artists << song.artist unless @artists.include?(song.artist)
    end
    @artists
  end

  def self.create(name)
    genre = self.new(name)
    genre.save
    genre
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end
end
