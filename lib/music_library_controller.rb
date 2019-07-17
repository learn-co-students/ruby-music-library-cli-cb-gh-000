require 'pry'
class MusicLibraryController

  def initialize(path="./db/mp3s")
    MusicImporter.new(path).import
  end

  def music
    @music = Song.all
  end

  def artists
    @artists = Artist.all
  end

  def genres
    @genres = Genre.all
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

    user_input = gets.chomp
    while user_input != "exit"
      if user_input == "list songs"
        self.list_songs
      elsif user_input == "list artists"
        self.list_artists
      elsif user_input == "list genres"
        self.list_genres
      elsif user_input == "list artist"
        self.list_songs_by_artist
      elsif user_input == "list genre"
        self.list_songs_by_genre
      elsif user_input == "play song"
        self.play_song
      end
      user_input = gets.chomp
    end
  end

  def sort_by_artist_name(array)
    array.sort_by do |artist|
      artist.name
    end
  end # => [artist name, song name, genre name]

  def uniq_by_artist_name(sorted_array)
    sorted_array.map.uniq do |artist|
      artist.name
    end
  end

  def sort_by_song_name(array)
    array.sort_by do |song|
      song.name
    end
  end # => [artist name, song name, genre name]

  def uniq_by_song_name(sorted_array)
    sorted_array.map.uniq do |song|
      song.name
    end
  end

  def sort_by_genre_name(array)
    array.sort_by do |genre|
      genre.name
    end
  end # => [artist name, song name, genre name]

  def uniq_by_genre_name(sorted_array)
    sorted_array.map.uniq do |genre|
      genre.name
    end
  end

  def list_songs
    sorted_music = self.sort_by_song_name(self.music)
    uniq_music = self.uniq_by_song_name(sorted_music)

    uniq_music.each_with_index do |song, index|
      count = index + 1
      puts "#{count}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end

  def list_artists
    sorted_artists = self.sort_by_artist_name(self.artists)
    uniq_artists = self.uniq_by_artist_name(sorted_artists)

    uniq_artists.each_with_index do |artist, index|
      count = index + 1
      puts "#{count}. #{artist.name}"
    end
  end

  def list_genres
    sorted_genres = self.sort_by_genre_name(self.genres)
    uniq_genres = self.uniq_by_genre_name(sorted_genres)

    uniq_genres.each_with_index do |genre, index|
      count = index + 1
      puts "#{count}. #{genre.name}"
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    artist_name = gets.chomp
    count = 0
    sorted_music = self.sort_by_song_name(self.music)
    sorted_music.each do |song|
      if song.artist.name == artist_name
        count += 1
        puts "#{count}. #{song.name} - #{song.genre.name}"
      end
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    genre_name = gets.chomp
    count = 0
    sorted_music = self.sort_by_song_name(self.music)
    sorted_music.each do |song|
      if song.genre.name == genre_name
        count += 1
        puts "#{count}. #{song.artist.name} - #{song.name}"
      end
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    song_number = gets.chomp.to_i
    if song_number.between?(1, self.music.count)
      sorted_music = self.sort_by_song_name(self.music)
      uniq_music = self.uniq_by_song_name(sorted_music)

      song_name = uniq_music[song_number - 1].name
      artist_name = uniq_music[song_number - 1].artist.name

      puts "Playing #{song_name} by #{artist_name}"
    end
  end

end
