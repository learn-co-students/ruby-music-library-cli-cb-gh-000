class Genre
  attr_accessor :name, :songs

  extend Concerns::Findable

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def self.all
    @@all.dup.freeze
  end

  def save
    @@all << self
  end

  def self.create(name)
    new(name).tap { |genre| genre.save }
  end

  def self.destroy_all
    @@all.clear
  end

  def add_song(song)
    song.genre = self unless song.genre == self
    @songs << song if song.is_a?(Song) && !songs.include?(song)
  end

  def artists
    @songs.collect { |song| song.artist }.uniq
  end

  def to_s
    self.name
  end
end
