class Song

  extend Concerns::Findable

  attr_accessor :name
  attr_reader :artist, :genre

  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist if artist
    self.genre = genre if genre
  end

  def self.all
    @@all
  end

  def self.destroy_all
    self.all.clear
  end

  def save
    self.class.all << self
  end

  def self.create(name, artist = nil, genre = nil)
    self.new(name, artist, genre).tap{ |song| song.save }
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.songs << self unless genre.songs.include?(self)
  end

  def self.new_from_filename(filename)
    filename.sub!(".mp3", "")
    artist = Artist.find_or_create_by_name(filename.split(" - ")[0])
    genre = Genre.find_or_create_by_name(filename.split(" - ")[2])
    self.new(filename.split(" - ")[1], artist, genre)
  end

  def self.create_from_filename(filename)
    self.new_from_filename(filename).tap do |song|
      song.save
    end
  end

end