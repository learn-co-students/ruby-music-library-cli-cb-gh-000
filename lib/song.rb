class Song
  #extend Concerns::Findable

  attr_accessor :name, :artist, :genre
  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    if artist
      self.artist = artist
    end
    if genre
      self.genre = genre
    end
  end

  def save
    self.class.all << self
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

  def genre=(genre)
    @genre = genre
    genre.add_song(self)
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def self.find_by_name(name)
    @@all.detect do |song|
      song.name == name
    end
  end

  def self.find_or_create_by_name(name)
    song = self.find_by_name(name)

    if song
      song
    else
      song = self.create(name)
    end
  end

  def self.new_from_filename(filename)
    filename_parts = filename.split(" - ")
    genre = filename_parts[2].split(".")[0]
    song = self.find_or_create_by_name(filename_parts[1])
    song.artist = Artist.find_or_create_by_name(filename_parts[0])
    song.genre = Genre.find_or_create_by_name(genre)
    return song
  end

  def self.create_from_filename(filename)
    song = self.new_from_filename(filename)
    song.save
    song
  end

end
