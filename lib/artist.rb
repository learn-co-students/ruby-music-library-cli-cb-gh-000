class Artist
  extend Concerns::Findable

  attr_accessor :name, :songs

  @@all = []

  def self.all
    @@all
  end

  def self.create(name)
    artist = new(name)
    artist.save

    artist
  end

  def self.destroy_all
    @@all.clear
  end

  def initialize(name)
    @name = name
    @songs = []
  end

  def add_song(song)
    if !@songs.include?(song) and song.is_a? Song
      @songs << song
      song.artist = self
    end
  end

  def genres
    @songs.collect { |song| song.genre }.uniq
  end

  def save
    @@all << self
  end
end
