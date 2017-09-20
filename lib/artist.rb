class Artist
  extend Concerns::Findable

  attr_accessor :name, :songs

  @@all = []
  @@songs = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def add_song(song)
    song.artist = self unless song.artist
    songs << song unless songs.include?(song)
  end

  def genres
    genres = []
    songs.each do |song|
      genres << song.genre unless genres.include?(song.genre)
    end
    genres
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all = []
  end

  def self.create(name)
    artist = new(name)
    artist.save
    artist
  end

  def save
    self.class.all << self
  end

end
