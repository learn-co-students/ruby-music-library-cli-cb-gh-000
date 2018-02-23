class Song
  attr_accessor :name
  attr_reader :artist, :genre

  @@all =[]

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist if artist
    self.genre = genre if genre
  end

  def name
    @name
  end

  def name=(name)
    @name = name
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.songs << self unless genre.songs.include?(self)
  end

  def self.all
    @@all
  end

  def artist
    @artist
  end

  def self.destroy_all
    self.all.clear
  end

  def save
    self.class.all << self
  end

  def self.find_by_name(name)
    @@all.find{|s| s.name == name}
  end

  def self.create(name)
    song = Song.new(name)
    song.save
    song
  end

  def self.find_or_create_by_name(name)
    find_by_name(name) || create(name)
  end

  def self.new_from_filename(filename)
    arr = filename.split(" - ")
    artist, song, genre = arr[0], arr[1], arr[2].gsub(".mp3","")
    artist = Artist.find_or_create_by_name(artist)
    genre = Genre.find_or_create_by_name(genre)
    new(song, artist, genre)
  end

  def self.create_from_filename(filename)
    new_from_filename(filename).save
  end
end
