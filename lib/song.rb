class Song
  extend Concerns::Findable

  attr_accessor :name, :artist, :genre

  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist
    self.genre = genre
  end

  def self.create(name)
    song = Song.new(name)
    song.save
    song
  end

  def self.all
    @@all
  end

  def self.destroy_all
    self.all.clear
  end

  def save
    @@all << self
  end

  def artist=(artist)
    if artist != nil
      @artist = artist
      artist.add_song(self)
    end
  end

  def genre=(genre)
    if genre != nil
      @genre = genre
      if !genre.songs.include?(self)
        genre.songs << self
      end
    end
  end

  def self.new_from_filename(filename)
    infos = filename.split(" - ")
    song = Song.new(infos[1])
    song.artist = Artist.find_or_create_by_name(infos[0])
    song.genre = Genre.find_or_create_by_name(infos[2].gsub(".mp3", ""))
    song
  end

  def self.create_from_filename(filename)
    Song.new_from_filename(filename).tap{|s| s.save}
  end


end
