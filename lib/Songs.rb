

class Song

  extend Concerns::Findable

  attr_accessor :name, :artist, :genre


  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist=(artist) if artist
    self.genre=(genre) if genre
    self.save
    if artist && genre
      artist.genres << artist if !artist.genres.include?(genre)
      genre.artists << artist if !genre.artists.include?(artist)
    end
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def save
    @@all << self
  end

  def self.create(name)
    Song.new(name)
  end


  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.songs << self if !genre.songs.include?(self)
  end

  def self.find_by_name(name)
    @@all.uniq.select { |song| song.name == name}[0]
  end

  def self.find_or_create_by_name(name)
    Song.find_by_name(name) || Song.create(name)
  end

  def self.new_from_filename(filename)
    song_data = filename.split(".")[0].split(" - ")
    artist = Artist.find_or_create_by_name(song_data[0])
    genre = Genre.find_or_create_by_name(song_data[2])
    song = self.new(song_data[1], artist, genre)
  end

  def self.create_from_filename(filename)
    Song.new_from_filename(filename)
  end

end
