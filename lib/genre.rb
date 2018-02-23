class Genre
  attr_accessor :name, :songs, :genre
  extend Concerns::Findable

  @@all =[]

  def initialize(name)
    @name = name
    @songs = []
  end

  def name
    @name
  end

  def name=(name)
    @name = name
  end

  def artists
    songs.collect {|s| s.artist}.uniq
  end

  def genre=(genre)
    @genre = genre
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

  def self.create(name)
    genre = Genre.new(name)
    genre.save
    genre
  end
end
