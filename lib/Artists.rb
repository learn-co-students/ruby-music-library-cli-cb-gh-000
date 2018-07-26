class Artist

  extend Concerns::Findable

  attr_accessor :name, :songs

  @@all = []

  def initialize(name)
      @name = name

      @songs = []
      self.save
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
    Artist.new(name)
  end

  def add_song(song)
    song.artist ||= self
    @songs << song if !@songs.include?(song)
  end

  def genres
    genres = @songs.collect { |song| song.genre}
    genres.uniq
  end

end
