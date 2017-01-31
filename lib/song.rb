class Song
  include Concerns::CommonFunctions::InstanceMethods
  extend Concerns::CommonFunctions::ClassMethods
  extend Concerns::Findable

  attr_accessor :name
  attr_reader :artist, :genre
  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist unless artist == nil
    self.genre = genre unless genre == nil
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.add_song(self)
  end

  def self.all
    @@all
  end

  def self.new_from_filename(filename)
    arr = filename.split(/\s-\s|\./)
    song = Song.find_or_create_by_name(arr[1])
    song.artist = Artist.find_or_create_by_name(arr[0])
    song.genre = Genre.find_or_create_by_name(arr[2])
    song
  end

  def self.create_from_filename(filename)
    self.new_from_filename(filename)
  end
end
