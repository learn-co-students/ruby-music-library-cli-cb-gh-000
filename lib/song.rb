class Song
  extend Concerns::Findable
  attr_accessor :name
  attr_reader :artist, :genre
  @@all = []
  def initialize(name, artist=nil, genre=nil)
    @name = name
    if !artist.nil?
      @artist = artist
      artist.add_song(self)
    end
    if !genre.nil?
      @genre = genre
      genre.add_song(self)
    end
  end
  def save
    @@all << self
  end
  def self.create(name)
    song = self.new(name)
    @@all << song
    song
  end
  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end
  def self.all
    @@all
  end
  def self.destroy_all
    @@all.clear
  end
  def genre=(genre)
    @genre = genre
    genre.add_song(self)
  end
  def self.new_from_filename(filename)
    file = filename.split(".")[0].split(" - ")
    song = self.new(file[1])
    artist = Artist.find_or_create_by_name(file[0])
    genre = Genre.find_or_create_by_name(file[2])
    song.artist = artist
    song.genre = genre
    song
  end
  def self.create_from_filename(filename)
    song = new_from_filename(filename)
    @@all << song
    song
  end
end