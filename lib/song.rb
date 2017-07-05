class Song

  attr_accessor :name
  attr_reader :artist, :genre

  @@all = []

  def initialize(name, artist=nil, genre=nil)
    @name = name

    if artist != nil
      self.artist = artist
    end

    if genre != nil
      self.genre = genre
    end
  end

  # to replace with module
  def save
    self.class.all << self
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.add_song(self)
  end

  def self.find_by_name(name)
    @@all.detect do |song|
      song.name == name
    end
  end

  def self.find_or_create_by_name(name)
    song = self.find_by_name(name)
    if !song
      song = self.create(name)
    end
    song
  end

  def self.new_from_filename(filename)
    data = filename.split(" - ")
    song = Song.new(data[1])
    artist = Artist.find_or_create_by_name(data[0])
    genre = Genre.find_or_create_by_name(data[2].split(".")[0])
    song.artist = artist
    song.genre = genre
    song
  end

  def self.create_from_filename(filename)
    song = self.new_from_filename(filename)
    song.save
    song
  end

  # to replace with module ?
  def self.create(name)
    song = Song.new(name)
    song.save
    song
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
