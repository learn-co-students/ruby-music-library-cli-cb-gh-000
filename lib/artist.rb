class Artist
  extend Concerns::Findable

  attr_accessor :name, :songs

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def genres
    genres = []
    self.songs.each do |song|
      if !genres.include?(song.genre)
        genres << song.genre
      end
    end
    genres
  end

  # to replace with module
  def save
    self.class.all << self
  end

  def add_song(song)
    if !self.songs.include?(song)
      self.songs << song
    end
    if song.artist != self
      song.artist = self
    end
  end

  # to replace with module ?
  def self.create(name)
    artist = Artist.new(name)
    artist.save
    artist
  end

  # to replace with module
  def self.all
    @@all
  end

  # to replace with module
  def self.destroy_all
    @@all.clear
  end
end
