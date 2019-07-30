class MusicLibraryController
  def initialize(path = './db/mp3s')
    mi = MusicImporter.new(path)
    mi.import
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
    str = gets
    while(str != "exit")
      if(str == "list songs")
        self.list_songs
      elsif str == "list artists"
        self.list_artists
      elsif str == "list genres"
        self.list_genres
      elsif str == "list artist"
        self.list_songs_by_artist
      elsif str == "list genre"
        self.list_songs_by_genre
      elsif str == "play song"
        self.play_song
      end
      str = gets
    end

  end

  def play_song
    puts "Which song number would you like to play?"
    song = gets.to_i
    songs = Song.all.sort_by {|song| song.name}
    if(song < songs.length && song > 0)
      puts "Playing " + songs[song-1].name + " by " + songs[song-1].artist.name
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    name = gets
    if(Artist.find_by_name(name) != nil)
      songs = Artist.find_by_name(name).songs.sort_by {|song| song.name}
      count = 0
      songs.each do |song|
        count += 1
        puts count.to_s + ". " + song.name + " - " + song.genre.name
      end
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    name = gets
    if(Genre.find_by_name(name) != nil)
      songs = Genre.find_by_name(name).songs.sort_by {|song| song.name}
      count = 0
      songs.each do |song|
        count += 1
        puts count.to_s + ". " + song.artist.name + " - " + song.name
      end
    end
  end

  def list_artists
    artists = Artist.all.sort_by {|artist| artist.name}
    count = 0
    artists.each do |artist|
      count += 1
      puts count.to_s + ". " + artist.name
    end
  end

  def list_genres
    genres = Genre.all.sort_by {|genre| genre.name}
    count = 0
    genres.each do |genre|
      count += 1
      puts count.to_s + ". " + genre.name
    end
  end

  def list_songs
    songs = Song.all.sort_by {|song| song.name}
    count = 0
    songs.each do |song|
      count += 1
      puts count.to_s + ". " + song.artist.name + " - " + song.name + " - " + song.genre.name
    end
  end
end
