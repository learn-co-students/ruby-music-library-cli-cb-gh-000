
class MusicLibraryController

  def initialize path = './db/mp3s'
    MusicImporter.new(path).import
    Song.all.map(&:artist).each &:save
    Song.all.map(&:genre ).each &:save
    @last_list = Song.all
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
    while (input = gets.strip.downcase) != 'exit'
      case input
      when 'list songs'
        list_songs
      when 'list artists'
        list_artists
      when 'list genres'
        list_genres
      when 'list artist'
        list_songs_by_artist
      when 'list genre'
        list_songs_by_genre
      when 'play song'
        play_song
      end
    end
  end

  def list_songs
    @last_list = Song.all
    @last_list.each_with_index do |song, index|
      puts "#{index+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end

  def list_artists
    @last_list = Artist.all
    @last_list.each_with_index do |artist, index|
      puts "#{index+1}. #{artist.name}"
    end
  end

  def list_genres
    @last_list = Genre.all
    @last_list.each_with_index do |genre, index|
      puts "#{index+1}. #{genre.name}"
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    artist = gets.strip
    artist = Artist.find_by_name artist
    return unless artist
    @last_list = artist.songs.sort_by(&:name)
    @last_list.each_with_index do |song, index|
      puts "#{index+1}. #{song.name} - #{song.genre.name}"
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    genre = gets.strip
    genre = Genre.find_by_name genre
    return unless genre
    @last_list = genre.songs.sort_by(&:name)
    @last_list.each_with_index do |song, index|
      puts "#{index+1}. #{song.artist.name} - #{song.name}"
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    song = gets.strip.to_i - 1
    if song.between? 0, @last_list.size - 1
      puts "Playing #{@last_list[song].name} by #{@last_list[song].artist.name}"
    end
  end
end
