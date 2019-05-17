class MusicLibraryController

  def initialize(path = "./db/mp3s")
    my_importer = MusicImporter.new(path)
    my_importer.import
  end

  def list_songs
    Song.all.sort_by {|song| song.name}.each_with_index do |song, index|
      puts "#{index +1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end

  def list_artists
    Artist.all.sort_by {|artist| artist.name}.each_with_index do |artist, index|
      puts "#{index +1}. #{artist.name}"
    end
  end

  def list_genres
    Genre.all.sort_by {|genre| genre.name}.each_with_index do |genre, index|
      puts "#{index +1}. #{genre.name}"
    end
  end

  def list_songs_by_artist
    secondary_input = nil
    artist_names = Artist.all.map(&:name)

    until artist_names.includes?(secondary_input)
      puts "Please enter the name of an artist:"
      secondary_input = gets.chomp
    end

    Artist.all.each do |artist|
      if artist.name == secondary_input
        artist.songs.sort_by{|song| song.name }.each_with_index do |song, index|
          puts "#{index}. #{song.name} - #{song.genre.name}"
        end
      end
    end
  end

  def list_songs_by_genre
    secondary_input = nil
    genres_names = Genre.all.map(&:name)

    until genre.names.includes?(secondary_input)
      secondary_input = gets.chomp
      puts "Please enter the name of a genre:"
    end

    Genre.all.each do |genre|
      if genre.name == secondary_input
        genre.songs.each_with_index do |song, index|
          puts "#{index}. #{song.artist.name} - #{song.name}"
        end
      end
    end
  end

  def play_song
    secondary_input = nil

    until (secondary_input.to_i >= 1 && secondary_input.to_i < Song.all.size)
      puts "Which song number would you like to play?"
      secondary_input = gets.chomp
    end

    song = Song.all[secondary_input.to_i]
    puts "Playing #{song.name} by #{song.artist.name}"
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

    input = nil

    while input != "exit" do

      puts "What would you like to do?"
      input = gets.chomp

      case input

      when "list songs"
        self.list_songs

      when "list artists"
        self.list_artists

      when "list genres"
        self.list_genres

      when "list artist"
        self.list_songs_by_artist

      when "list genre"
        self.list_songs_by_genre

      when "play song"
        self.play_song

      else
        puts ">>>>"
      end
    end

  end


end
