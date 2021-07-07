

class Song
  extend Memorable::ClassMethods, Concerns::Findable
  include Memorable::InstanceMethods

  attr_accessor :name
  attr_reader :artist, :genre
  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    if artist != nil
      self.artist = artist
    end
    if genre != nil
      self.genre = genre
    end
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    if genre.songs.include?(self) == false
      genre.songs << self
    end
  end

  def self.new_from_filename(file_name)
    name = file_name.split(" - ") # 0 - song name, 1 - artist name, 2 - genre name
    artist = Artist.find_or_create_by_name(name[0])
    song_name = name[1]
    genre = Genre.find_or_create_by_name(name[2].split(".mp3").first)
    self.new(song_name, artist, genre)
  end

  def self.create_from_filename(file_name)
    self.all << self.new_from_filename(file_name)
  end

  def self.all
    @@all
  end

end
