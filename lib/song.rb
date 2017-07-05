class Song
  extend Concerns::Findable

  attr_accessor :name
  attr_reader :artist, :genre

  @@all = []

  def initialize(name, artist=nil, genre=nil)
    @name = name
    self.artist = artist unless artist.nil?
    self.genre = genre unless genre.nil?
  end

  def self.all
    @@all
  end

  def self.destroy_all
    self.all.clear
  end

  def self.create(name)
    self.new(name).save
  end

  def self.new_from_filename(filename)
    song_properties = filename.split(" - ")

    artist_name = song_properties[0]
    song_name = song_properties[1]
    genre_name = song_properties[2].gsub(".mp3","")

    song = Song.new(song_name)
    song.artist_name = artist_name
    song.genre_name = genre_name
    song
  end

  def self.create_from_filename(filename)
    song_properties = filename.split(" - ")

    artist_name = song_properties[0]
    song_name = song_properties[1]
    genre_name = song_properties[2].gsub(".mp3","")

    song = Song.new(song_name)
    song.artist_name = artist_name
    song.genre_name = genre_name
    song.save
    song
  end

  def save
    self.class.all << self
    self
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def artist_name=(artist_name)
    artist = Artist.find_or_create_by_name(artist_name)
    self.artist = artist
  end

  def genre=(genre)
    @genre = genre
    genre.add_song(self)
  end

  def genre_name=(genre_name)
    genre = Genre.find_or_create_by_name(genre_name)
    self.genre = genre
  end
end
