class MusicLibraryController

  def initialize(path = "./db/mp3s")
    music_importer = MusicImporter.new(path)
    music_importer.import
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
    input = gets.chomp
    until input == "exit"
      case input
        when "list songs"
          list_songs
        when "list artists"
          list_artists
        when "list genres"
          list_genres
        when "list artist"
          list_songs_by_artist
        when "list genre"
          list_songs_by_genre
        when "play song"
          play_song
        else
      end

      input = gets.chomp
    end
  end

  def list_songs
    alphabetized_songs = Song.all.sort { |a, b|
      a.name <=> b.name
    }
    alphabetized_songs.each_with_index do |song, index|
      puts "#{index + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end

  def list_artists
    alphabetized_artists = Artist.all.sort { |a, b|
      a.name <=> b.name
    }
    alphabetized_artists.each_with_index do |artist, index|
      puts "#{index + 1}. #{artist.name}"
    end
  end

  def list_genres
    alphabetized_genres = Genre.all.sort { |a, b|
      a.name <=> b.name
    }
    alphabetized_genres.each_with_index do |genre, index|
      puts "#{index + 1}. #{genre.name}"
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    artist_name = gets.chomp
    artist = Artist.find_by_name(artist_name)
    if artist != nil
      artist.songs.sort { |a, b|  a.name <=> b.name }.each_with_index do |song, index|
        puts "#{index + 1}. #{song.name} - #{song.genre.name}"
      end
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    genre_name = gets.chomp
    genre = Genre.find_by_name(genre_name)
    if genre != nil
      genre.songs.sort { |a, b|  a.name <=> b.name }.each_with_index do |song, index|
        puts "#{index + 1}. #{song.artist.name} - #{song.name}"
      end
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    song_number = gets.chomp.to_i
    alphabetized_songs = Song.all.sort { |a, b|
      a.name <=> b.name
    }
    if song_number.between?(1, alphabetized_songs.length)
      song = alphabetized_songs[song_number - 1]
      puts "Playing #{song.name} by #{song.artist.name}"
    end
  end

end
