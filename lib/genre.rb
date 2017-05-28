require 'pry'

class Genre

  extend Concerns::Memorable::ClassMethods
  include Concerns::Memorable::InstanceMethods
  extend Concerns::Findable

  @@all = []

  def self.all
    @@all
  end


  attr_accessor :name
  attr_reader :songs

  def initialize(name)
    super(name)
    @songs = []
  end

  def add_song(song)
    # This "if not" prevents a loop of song.genre=() > genre.add_song() > song.genre=()
    if not @songs.include?(song)
      @songs << song
      song.genre = self
    end
  end

  # Returns unique artists via the songs
  def artists
    @songs.collect { |song| song.artist }.uniq
  end

end
