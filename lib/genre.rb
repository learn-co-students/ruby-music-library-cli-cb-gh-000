class Genre
  extend Concerns::Findable
  attr_accessor :name, :songs

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def save
    @@all << self
  end

  def add_song(song)
    song.genre = self unless song.genre
    @songs << song unless @songs.include?(song)
  end

  def songs
    @songs
  end

  def self.create(name)
    song = Song.new(name)
    @@all << song
    song
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def artists
    result = @songs.collect do |x|
      x.artist
    end
    result.uniq
  end
end
