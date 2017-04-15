class MusicLibraryController
  def initialize(path="./db/mp3s")
    @path = path
    MusicImporter.new(@path).import
  end

  def call
    input = nil

    until input == "exit"
      input = gets.chomp

      if input == "list songs"
        sorted_songs = []

        Song.all.each do |song|
          sorted_songs << "#{song.artist.name} - #{song.name} - #{song.genre.name}"
          sorted_songs = sorted_songs.sort
        end

        sorted_songs.each_with_index do |song, index|
          puts "#{index + 1}. #{song}"
        end
      end

      if input == "list artists"
        sorted_artists = []
        Song.all.each { |song| sorted_artists << song.artist.name }
        sorted_artists = sorted_artists.sort
        sorted_artists = sorted_artists.uniq
        sorted_artists.each { |artist| puts artist }
      end

      if input == "list genres"
        sorted_genres = []
        Song.all.each { |song| sorted_genres << song.genre.name }
        sorted_genres = sorted_genres.sort
        sorted_genres = sorted_genres.uniq
        sorted_genres.each { |genre| puts genre }
      end

      if input == "play song"
        song_number = gets.chomp.to_i - 1

        sorted_songs = []

        Song.all.each do |song|
          sorted_songs << "#{song.artist.name} - #{song.name} - #{song.genre.name}"
          sorted_songs = sorted_songs.sort
        end

        puts "Playing #{sorted_songs[song_number]}"
      end

      if input == "list artist"
        artist = gets.chomp
        artist = Artist.find_by_name(artist)

        artist.songs.each do |song|
          puts "#{song.artist.name} - #{song.name} - #{song.genre.name}"
        end
      end

      if input == "list genre"
        genre = gets.chomp
        genre = Genre.find_by_name(genre)

        genre.songs.each do |song|
          puts "#{song.artist.name} - #{song.name} - #{song.genre.name}"
        end
      end

    end
  end
end
