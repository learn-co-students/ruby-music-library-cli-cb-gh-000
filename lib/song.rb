class Song

  extend Concerns::Findable

  attr_accessor :name

  attr_reader :artist, :genre

  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist
    self.genre = genre
  end

  def artist=(artist)
    if artist.is_a? Artist
      @artist = artist
      @artist.add_song(self)
    end
  end

  def genre=(genre)
    if genre.is_a? Genre and @genre != genre
      @genre = genre
      @genre.songs << self
    end
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def save
    if !self.class.all.include?(self)
      self.class.all << self
    end
    self
  end

  def self.create(name)
    song = self.find_by_name(name) || self.new(name)
    song.save
  end

  def self.new_from_filename(filename)
    parts = filename.split(" - ")
    song = self.find_by_name(parts[1]) || self.new(parts[1])
    song.artist = Artist.find_by_name(parts[0]) || Artist.new(parts[0])
    song.genre = Genre.find_by_name(parts[2][0..-5]) || Genre.new(parts[2][0..-5])
    song
  end

  def self.create_from_filename(filename)
    parts = filename.split(" - ")
    song = self.find_or_create_by_name(parts[1])
    song.artist = Artist.find_or_create_by_name(parts[0])
    song.genre = Genre.find_or_create_by_name(parts[2][0..-5])
    song
  end
end
