class Genre

  extend Concerns::Findable

  attr_accessor :name, :songs

  @@all = []


  def initialize(name)
    @name = name
    @songs = []
  end

  def artists
    tmp = @songs.collect {|song| song.artist}
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
    genre = self.find_by_name(name) || self.new(name)
    genre.save
  end
end
