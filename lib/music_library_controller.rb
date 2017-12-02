require_relative "music_importer"
require "pry"
require_relative "artist"
require_relative "genre"

class MusicLibraryController
  attr_reader :music
  attr_accessor :current_list
  def initialize(path = "./db/mp3s")
    @music = MusicImporter.new(path)
    @music.import
    self.current_list = []
  end
  def call
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"
    choice = nil
    until choice == "exit"
      choice = gets.strip
      if ["list songs", "list artists", "list genres", "play song"].include?(choice)
        self.send(choice.split(" ").join("_"))
      elsif choice == "list artist"
        self.list_songs_by_artist
      elsif choice == "list genre"
        self.list_songs_by_genre
      end
    end
  end
  def list_songs
    self.current_list = self.music
      .library
      .sort_by { |e| e.name }
      .each_with_index { |e, i| puts "#{i+1}. #{e.artist.name} - #{e.name} - #{e.genre.name}" }
  end
  def list_artists
    self.music
      .library[0]
      .artist
      .class
      .all
      .sort_by { |e| e.name }
      .each_with_index { |e,i| puts "#{i+1}. #{e.name}"}
  end

  def list_genres
    self.music
      .library[0]
      .genre
      .class
      .all
      .sort_by { |e| e.name }
      .each_with_index { |e,i| puts "#{i+1}. #{e.name}"}
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    artist = Artist.find_by_name(gets.strip)
    return nil if !artist
    self.current_list = artist.songs
      .sort_by(&:name)
      .each_with_index { |e, i| puts "#{i+1}. #{e.name} - #{e.genre.name}" }
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    genre = Genre.find_by_name(gets.strip)
    return nil if !genre
    self.current_list = genre.songs
      .sort_by(&:name)
      .each_with_index { |e, i| puts "#{i+1}. #{e.artist.name} - #{e.name}" }
  end

  def play_song
    puts "Which song number would you like to play?"
    choice = gets.strip.to_i - 1
    unless choice > 0 && choice <= self.music.library.length
      return
    end
    self.current_list = self.music.library.sort_by(&:name) if self.current_list.length == 0
    song = self.current_list[choice]
    puts "Playing #{song.name} by #{song.artist.name}" if song
  end

end

binding.pry
