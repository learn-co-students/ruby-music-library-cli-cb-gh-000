class MusicLibraryController

  def initialize(path = nil)
    path = './db/mp3s' unless path
    MusicImporter.new(path).import
  end

  def call
    puts "Music CLI: Hello!"
    puts "Music CLI: Welcome to the Music CLI main menu."

    loop do
      puts "Music CLI: Please enter one of the following avalaible commands:"
      puts "`list songs`, `list artists`, `list genres`, `play song`, `exit`"
      
      cli_state = gets.chomp
      case cli_state

        when "exit"
          puts "Music CLI: Bye Bye!"
          break

        when "list songs"
          Song.all.each.with_index do |song, index|
            puts "#{index+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
          end

        when "list artists"
          Artist.all.each do |artist|
            puts artist.name
          end
          temp_state = gets.chomp
          if temp_state == 'exit'
            break
          else
            Artist.find_by_name(temp_state).songs.each do |song|
              puts "#{song.artist.name} - #{song.name} - #{song.genre.name}"
            end
          end

        when "list genres"
          Genre.all.each do |genre|
            puts genre.name
          end
          temp_state = gets.chomp
          if temp_state == 'exit'
            break
          else
            Genre.find_by_name(temp_state).songs.each do |song|
              puts "#{song.artist.name} - #{song.name} - #{song.genre.name}"
            end
          end

        when "play song"
          puts "Music CLI: Enter the number of the song you want to play."
          song_index = gets.chomp.to_i - 1
          puts "Playing #{Song.all[song_index].artist.name} - #{Song.all[song_index].name} - #{Song.all[song_index].genre.name}"

      end
    end
  end

end