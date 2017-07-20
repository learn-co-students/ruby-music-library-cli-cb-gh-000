class Song

  @@all = []
  attr_accessor :name, :genre
  attr_reader :artist

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist
    self.genre = genre
  end

  def save
    @@all << self
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self) unless artist == nil
  end

  def genre=(genre)
    if genre != nil
      @genre = genre
      genre.songs << self unless genre.songs.include?(self)
    end
  end

  def self.new_from_filename(filename)
    filename_array = filename.split(" - ")
    artist_name = filename_array[0]
    song_name = filename_array[1]
    song_genre = filename_array[2].split(".")[0]
    song = self.new(song_name, Artist.find_or_create_by_name(artist_name), Genre.find_or_create_by_name(song_genre))
    song
  end

  def self.create_from_filename(filename)
    song = self.new_from_filename(filename)
    song.save
    song
  end

  def self.create(name, artist = nil)
    song = self.new(name, artist)
    song.save
    song
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def self.find_by_name(name)
    self.all.each do |song|
      return song if song.name == name
    end
    nil
  end

  def self.find_or_create_by_name(name)
    song = self.find_by_name(name)
    return song unless song == nil
    self.create(name)
  end

end
