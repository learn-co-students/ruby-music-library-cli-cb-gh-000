require 'pry'

class Artist

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
    # This "if not" prevents a loop of song.artist=() > artist.add_song() > song.artist=()
    if not @songs.include?(song)
      @songs << song
      song.artist = self
    end
  end

  # Returns unique genres via the songs
  def genres
    @songs.collect { |song| song.genre }.uniq
  end

  # def add_songs(songs)
  #   songs.each { |song| add_song(song) }
  # end

end
