
class Song

  @@all = []

  def self.all
    @@all.sort_by &:name
  end

  def self.destroy_all
    @@all = []
  end

  def self.create *args
    item = self.new *args
    item.save
    item
  end

  def self.new_from_filename filename
    filename = File.basename filename, '.mp3'
    parts = filename.split ' - '
    self.new parts[1], parts[0], parts[2]
  end

  def self.create_from_filename filename
    item = self.new_from_filename filename
    item.save
  end

  extend Concerns::Findable

  attr_accessor :name
  attr_reader   :artist
  attr_reader   :genre

  def initialize name, artist = nil, genre = nil
    @name       = name
    self.artist = artist.is_a?(String) ? Artist.find_or_create_by_name(artist) : artist if artist
    self.genre  = genre.is_a?(String)  ? Genre.find_or_create_by_name(genre)   : genre  if genre
  end

  def save
    return if self.class.find_by_name @name
    @@all << self
  end

  def artist= artist
    @artist = artist
    artist.add_song self
  end

  def genre= genre
    @genre = genre
    genre.add_song self
  end
end
