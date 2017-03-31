class MusicLibraryController

  attr_reader :path, :input

  def initialize(path = "./db/mp3s")
    @path = path
    @input = []
    MusicImporter.new(@path).import
  end

  def call
    greetings
    input = nil
    until input == "exit" do
      print "\nInsert your command >>"
      input = gets.strip
        @input << input
        if @input.last == "list songs"
          list_songs
        end
        if @input.last == "list artists"
          list_artists
        end
        if @input.last == "list genres"
          list_genres
        end
        if @input.last == "play song"
          play_song
        end
        if @input.last == "list artist"
          list_artist
        end
        if @input.last == "list genre"
          list_genre
        end
    end
  end

  def greetings
    puts "#{'-'*10} Welcome to the MUSIC CLI #{'-'*10}"
    puts ""
    puts "#{'-'*10} Commands: "
    puts "#{'-'*5} 1.list songs   - will list you songs"
    puts "#{'-'*5} 2.list artists - will list you artists"
    puts "#{'-'*5} 3.list genres  - will list you genres"
    puts "#{'-'*5} 4.play song    - play choosen song"
    puts "#{'-'*5} 5.exit - exit"
  end

  def list_songs
    puts "Listing songs..."
    sleep(1)
    Song.all.each_with_index do |song,index|
      puts "#{index+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end

  def list_artists
    puts "Listing artists..."
    sleep(1)
    Artist.all.each do |artist|
      puts "#{artist.name}"
    end
  end

  def list_genres
    puts "Listing genres..."
    sleep(1)
    Genre.all.each do |genre|
      puts "#{genre.name}"
    end
  end

  def play_song
    print "\nWhich song?"
    list_songs
    print "\n\tChoose one >> "
    input = gets.strip
    @input << input
    unless input == "exit"
      song = Song.all[input.to_i-1]
      puts "\n\tPlaying #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end

  def list_artist
    print "\nWhich artist?"
    list_artists
    print "\n\tChoose one >> "
    input = gets.strip
    @input << input
    unless input == "exit"
      songs = Song.all.select{|song| song.artist.name == input}
      songs.each do |song|
        puts "#{song.artist.name} - #{song.name} - #{song.genre.name}"
      end
    end
  end

  def list_genre
    print "\nWhich genre?"
    list_genres
    print "\n\tChoose one >> "
    input = gets.strip
    @input << input
    unless input == "exit"
      songs = Song.all.select{|song| song.genre.name == input}
      songs.each do |song|
        puts "#{song.artist.name} - #{song.name} - #{song.genre.name}"
      end
    end
  end

end
