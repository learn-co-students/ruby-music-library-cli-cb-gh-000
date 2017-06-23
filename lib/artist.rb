
class Artist

  @@all = []

  def self.all
    @@all.sort_by &:name
  end

  def self.destroy_all
    @@all = []
  end

  def self.create *args
    item = self.new *args
    item.save
    item
  end

  extend Concerns::Findable

  attr_accessor :name
  attr_reader   :songs

  def initialize name
    @name  = name
    @songs = []
  end

  def save
    return if self.class.find_by_name @name
    @@all << self
  end

  def add_song song
    return if @songs.any?{|osong| osong.name == song.name}
    @songs << song
    song.artist = self if song.artist.nil?
  end

  def genres
    @songs.map(&:genre).uniq.sort_by &:name
  end
end
