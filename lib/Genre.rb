class Genre

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
    Genre.new(name)
  end

  def artists
    artists = @songs.collect { |song| song.artist }
    artists.uniq
  end

end
