class Song
  attr_accessor :name, :artist, :genre
  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    if artist.class == Artist
      self.artist=(artist)
    end
    if genre.class == Genre
      self.genre=(genre)
    end
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    if !genre.songs.include?(self)
      genre.songs << self
    end
  end

  def save
    @@all << self
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def self.create(name)
    song = Song.new(name)
    song.save
    song
  end

  def self.find_by_name(name)
    @@all.detect { |song| song.name == name }
  end

  def self.find_or_create_by_name(name)
    self.find_by_name(name) or self.create(name)
  end

  def self.new_from_filename(filename)
    arr = filename.split(" - ")

    artist = Artist.find_or_create_by_name(arr[0])
    genre = Genre.find_or_create_by_name(arr[2].split(".mp3").join())
    song = Song.new(arr[1], artist, genre)
    song
  end

  def self.create_from_filename(filename)
    song = Song.new_from_filename(filename)
    song.save
    song
  end
end
