class Song
  attr_accessor :name
  attr_reader :artist
  attr_reader :genre
  @@all = []
  def initialize(name, artist = nil, genre = "")
    @name = name
    @artist = artist
    if genre != nil
      @genre = genre
    end
    # instance_variable_set("@genre", genre)
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
    song = self.new(name)
    song.save
    song
  end
  
  def artist=(artist)
    artist.add_song(self)
    @artist = artist
  end
  
  def genre=(genre)
    @genre = genre
    if !genre.songs.include?(self)
      genre.songs << self
    end
    @genre
  end
end