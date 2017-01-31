class MusicLibraryController
  
  def initialize(path = "./db/mp3s")
    @importer = MusicImporter.new(path)
    @importer.import
  end

  def call
    input = ""
    loop do
      case input
      when "exit"
        break
      when "list songs"
        self.class.list_songs
      when "list artists"
        Artist.all.each do |artist|
          puts "#{artist.name}"
        end
      when "list genres"
        Genre.all.each do |genre|
          puts "#{genre.name}"
        end
      when "play song"
        input = gets.strip
        puts "Playing #{self.class.return_song_meta(input.to_i - 1)}"
      when "list artist"
        input = gets.strip
        Artist.find_or_create_by_name(input).songs.each do |song|
          puts self.class.return_song_meta(Song.all.find_index(song))
        end
      when "list genre"
        input = gets.strip
        Genre.find_or_create_by_name(input).songs.each do |song|
          puts self.class.return_song_meta(Song.all.find_index(song))
        end
      end
      input = gets.strip
    end
  end

  def self.list_songs
    Song.all.each_with_index do |song, i|
      puts "#{i + 1}. #{self.return_song_meta(i)}"
    end
  end

  def self.return_song_meta(index)
    "#{Song.all[index].artist.name} - #{Song.all[index].name} - #{Song.all[index].genre.name}"
  end
end