class Artist

  extend Concerns::Findable

  attr_accessor :name, :songs

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def genres
    tmp = @songs.collect {|song| song.genre}
    tmp.uniq
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def save
    if !self.class.all.include?(self)
      self.class.all << self
    end
    self
  end

  def self.create(name)
    artist = self.find_by_name(name) || self.new(name)
    artist.save
  end

  def add_song(song)
    if !@songs.include?(song) and song.is_a? Song
      @songs << song
      song.artist = self
    end
  end

end
