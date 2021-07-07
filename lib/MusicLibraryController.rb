

class MusicLibraryController

  def initialize(path = "./db/mp3s")
    MusicImporter.new(path).import
  end

  def call
    input = ""
    until input == "exit" do
      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"
      input = gets
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
      end
    end
  end

  def print_songs
    Song.all.each_with_index{|song, index| puts "#{index + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"}
  end

  def list_songs
    Song.all.sort_by!{|song| song.name}
    print_songs
  end

  def list_artists
    artists = Artist.all.sort_by{|artist| artist.name}
    artists.each_with_index{|artist, index| puts "#{index + 1}. #{artist.name}"}
  end

  def list_genres
    genres = Genre.all.sort_by{|genre| genre.name}
    genres.each_with_index{|genre, index| puts "#{index + 1}. #{genre.name}"}
  end


  def order_songs_by_class(class_name)
    instance_name = gets
    instance = class_name.find_by_name(instance_name)
    if instance
      instance.songs.sort_by!{|song| song.name}
    end
    instance
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    artist = order_songs_by_class(Artist)
    if artist
      artist.songs.each_with_index{|song, index| puts "#{index+1}. #{song.name} - #{song.genre.name}"}
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    genre = order_songs_by_class(Genre)
    if genre
      genre.songs.each_with_index{|song, index| puts "#{index+1}. #{song.artist.name} - #{song.name}"}
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    input = gets.to_i
    if input > 0 && input < Song.all.size
      order = Song.all.sort_by{|song| song.name}
      song = order[input.to_i - 1]
      if song
        puts "Playing #{song.name} by #{song.artist.name}"
      end
    end
  end
end
