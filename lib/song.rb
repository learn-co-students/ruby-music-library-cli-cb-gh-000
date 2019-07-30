class Song

  @@all = []
  attr_accessor :name
  attr_reader :artist, :genre

  def initialize(name, artist = nil, genre = nil)
    @name = name
    if artist != nil
      self.artist = artist
    end
    if genre != nil
      self.genre = genre
    end
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all = []
  end

  def save
    @@all << self
  end

  def genre=(genre)
    if(!genre.songs.include?(self))
      genre.songs << self
    end
    if(@genre == nil)
      @genre = genre
    end
  end

  def artist=(artist)
    if(@artist == nil)
      @artist = artist
    end

    if(self.artist != nil)
      artist.add_song(self)
    end
    @artist
  end

  def self.create(name)
    song = Song.new(name)
    song.save
    return song
  end

  def self.find_by_name(name)
    cl = self.all.select do |stuff|
      stuff.name == name
    end

    if(cl.empty?)
      return nil
    end

    return cl[0]
  end

  def self.find_or_create_by_name(name)
    cl = self.find_by_name(name)

    if(cl == nil)
      cl = Song.create(name)
    end

    return cl
  end

  def self.new_from_filename(filename)
    song = Song.new(filename.split(" - ")[1])
    song.artist = Artist.find_or_create_by_name(filename.split(" - ")[0])
    song.genre = Genre.find_or_create_by_name(filename.split(" - ")[2].split(".")[0])
    return song
  end

  def self.create_from_filename(filename)
    song = Song.new_from_filename(filename)
    song.save
    return song
  end
end
