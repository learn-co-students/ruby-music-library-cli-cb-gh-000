class Song
  attr_accessor :name
  attr_reader :artist
  attr_reader :genre
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
  
  def self.find_by_name(name)
    self.all.each{|song|
      if song.name == name
        return song
      end
    }
    return nil
  end
  
  def self.find_or_create_by_name(name)
    if self.find_by_name(name) == nil
      self.create(name)
    else
      return self.find_by_name(name)
      
    end
  end
end