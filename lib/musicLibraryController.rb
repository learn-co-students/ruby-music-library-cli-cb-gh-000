class MusicLibraryController

  def initialize(path = "./db/mp3s")
    @music_importer = MusicImporter.new(path).import
  end

  def call
    input = nil
    until input == "exit"
      input = gets.chomp
      case input
        when "list songs"
          list_all_songs
        when "list artists"
          list_all_artists
        when "list genres"
          list_all_genres
        when "play song"
          play_song
        when "list artist"
          artist_name = gets.chomp
          find_artist(artist_name)
        when "list genre"
          genre_name = gets.chomp
          find_genre(genre_name)
      end
    end
  end

  private
  def list_all_songs
    i = 0
    Artist.all.each do |artist|
      artist.songs.each do |song|
        puts "#{i+1}. #{artist.name} - #{song.name} - #{song.genre.name}"
        i += 1
      end
    end
  end

  private
  def list_all_artists
    Artist.all.each do |artist|
      puts artist.name
    end
  end

  private
  def list_all_genres
    Genre.all.each do |genre|
      puts genre.name
    end
  end

  private
  def play_song
    song = Song.all.first
    puts "Playing #{song.artist.name} - #{song.name} - #{song.genre.name}"
  end

  private
  def find_artist(name)
    artist = Artist.find_by_name(name)
    artist.songs.each do |song|
      puts "#{artist.name} - #{song.name} - #{song.genre.name}"
    end
  end

  private
  def find_genre(name)
    genre = Genre.find_by_name(name)
    genre.songs.each do |song|
      puts "#{song.artist.name} - #{song.name} - #{genre.name}"
    end
  end

end
