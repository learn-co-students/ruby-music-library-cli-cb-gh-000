require_relative "concerns"
class Song
  include Concerns

  @@all = []

  def self.all
    @@all
  end

  def self.new_from_filename filename
    date = MusicImporter.parse filename
    artist = Artist.find_or_create_by_name(date[:artist_name])
    genre = Genre.find_or_create_by_name(date[:genre_name])
    Song.new(date[:song_name],artist,genre)
  end

  def self.create_from_filename filename
    song = self.new_from_filename filename
    song.save
  end

  attr_accessor :name
  attr_reader :artist,:genre

  def initialize name, artist=nil,genre=nil
    @name = name
    @artist = artist
    @genre  = genre
    @artist.add_song self if @artist
    @genre.add_song self if @genre
  end

  def artist= candidate
    @artist = candidate
    @artist.add_song self
  end

  def genre= candidate
    @genre = candidate
    @genre.add_song self
  end
end
