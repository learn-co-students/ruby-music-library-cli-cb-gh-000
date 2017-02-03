require_relative "music_importer.rb"
require_relative "song.rb"
require_relative "genre.rb"
require_relative "artist.rb"

class MusicLibraryController

  attr_accessor :importer

  def initialize(path="./db/mp3s")
    @importer = MusicImporter.new path
    importer.import
  end

  def call
    inputs = []
    input = gets
    while input != "exit"
      inputs << input
      input = gets
    end

    case inputs[0]
    when "play song"
      idx = inputs[1].to_i
      song = Song.all[idx - 1]
      puts "Playing #{song.artist.name} - #{song.name} - #{song.genre.name}"
    when "list songs"
      Song.all.sort { |a, b| a.artist.name <=> b.artist.name } .each_with_index do |song, idx|
        puts "#{idx+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
      end
    when "list artists"
      Artist.all.each do |artist|
        puts artist.name
      end
    when "list artist"
      artist_name = inputs[1]
      Song.all.select { |song| song.artist.name == artist_name } .each do |song|
        puts "#{song.artist.name} - #{song.name} - #{song.genre.name}"
      end
    when "list genres"
      Genre.all.each do |genre|
        puts genre.name
      end
    when "list genre"
      genre_name = inputs[1]
      Song.all.select { |song| song.genre.name == genre_name } .each do |song|
        puts "#{song.artist.name} - #{song.name} - #{song.genre.name}"
      end
    end
  end

end
