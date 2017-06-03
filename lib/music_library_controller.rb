require 'pry'
class MusicLibraryController

  def initialize(path='./db/mp3s')
    @music_importer = MusicImporter.new(path)
    @music_importer.import
  end
  def list_songs
    Song.all.sort_by{|song| song.artist.name}.each_with_index{|song, ind|
      puts "#{ind + 1}. #{[song.artist.name, song.name, song.genre.name].join(' - ')}"
    }
  end
  def list_artists
    Artist.all.each{|artist| puts artist.name}
  end
  def list_genres
    Genre.all.each{|genre| puts genre.name}
  end
  def list_by_artist(artist)
    puts Song.all.select{|song| song.artist.name == artist}.collect{|song| display_song(song)}
  end
  def list_by_genre(genre)
    puts Song.all.select{|song| song.genre.name == genre}.collect{|song| display_song(song)}
  end
  def display_song(song)
    [song.artist.name, song.name, song.genre.name].join(' - ')
  end
  def play_song(song_index)
    song = Song.all.sort_by{|song| song.artist.name}[song_index]
    puts "Playing #{display_song(song)}"
  end
  def call
    input = ""
    while input != "exit"
      input = gets.strip
      case input
        when "list songs"
          list_songs
        when "list artists"
          list_artists
        when "list genres"
          list_genres
        when "list artist"
          artist_selection = gets.strip
          list_by_artist(artist_selection)
        when "list genre"
          genre_selection = gets.strip
          list_by_genre(genre_selection)
        when "play song"
          song_index = gets.strip.to_i - 1
          play_song(song_index)
      end
    end
  end
end