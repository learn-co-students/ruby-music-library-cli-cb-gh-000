class MusicLibraryController

  attr_accessor :path, :music

  def initialize(path = './db/mp3s')
    @path = path
    @music = MusicImporter.new(@path).import

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

    user_input = ""
    until user_input == "exit"
      user_input = gets.chomp

      case user_input
        when 'list songs'
          self.list_songs
        when 'list artists'
          self.list_artists
        when 'list genres'
          self.list_genres
        when 'list artist'
          self.list_songs_by_artist
        when 'list genre'
          self.list_songs_by_genre
        when 'play song'
          self.play_song
      end
    end
  end

  def list_songs
    title_sorted = @music.sort do |song_a, song_b|
      a = song_a.split(" - ")
      b = song_b.split(" - ")
      a[1] <=> b[1]
    end
    title_sorted.each_with_index do |song, index|
      string = song.split(".mp3")
      puts "#{index + 1}. #{string[0]}"
    end
    title_sorted
  end

  def list_artists
    artists = Artist.all.sort_by { |artist| artist.name}
    artists.each_with_index {|artist, index| puts "#{index + 1}. #{artist.name}"}
  end

  def list_genres
    genres = Genre.all.sort_by { |genre| genre.name}
    genres.each_with_index {|genre, index| puts "#{index + 1}. #{genre.name}"}
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    user_input = gets.chomp
    if artist = Artist.find_by_name(user_input)
      songs = artist.songs.sort_by { |song| song.name }
      songs.each.with_index { |song, index| puts "#{index + 1}. #{song.name} - #{song.genre.name}" }
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    user_input = gets.chomp
    if genre = Genre.find_by_name(user_input)
      songs = genre.songs.sort_by { |song| song.name }
      songs.each_with_index { |song,index| puts "#{index + 1}. #{song.artist.name} - #{song.name}"}
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    user_input = gets.chomp.to_i
    if user_input >= 1 && user_input <= Song.all.length
      song = Song.all.sort_by {|song| song.name}[user_input - 1]
      puts "Playing #{song.name} by #{song.artist.name}"
    end

  end

end
