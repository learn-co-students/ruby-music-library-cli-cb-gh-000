class Genre
  extend Concerns::Findable

  attr_accessor :name, :songs

  @@all = []

  def self.all
    @@all
  end

  def self.create(name)
    genre = new(name)
    genre.save

    genre
  end

  def self.destroy_all
    @@all.clear
  end

  def initialize(name, songs = [])
    @name = name
    @songs = songs
  end

  def add_song(song)
    if !@songs.include?(song) and song.is_a? Song
      @songs << song
      song.genre = self
    end
  end

  def artists
    @songs.collect { |song| song.artist }.uniq
  end

  def save
    @@all << self
  end
end
