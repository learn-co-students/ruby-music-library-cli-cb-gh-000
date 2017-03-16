class MusicLibraryController
  attr_reader :path

  def initialize(path = "./db/mp3s")
    importer = MusicImporter.new(path)
    importer.import
    self
  end

  def call
    loop do
      input = gets.chomp
      case input.downcase
      when "list songs"
        Song.all.each.with_index { |song, i| puts "#{i + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}" }
      when "list artists"
        Artist.all.each { |artist| puts artist.name }
      when "list genres"
        Genre.all.each { |genre| puts genre.name }
      when "play song"
        index = gets.chomp.to_i - 1
        song = Song.all[index]
        puts "Playing #{song.artist.name} - #{song.name} - #{song.genre.name}"
      when "list artist"
        artist = Artist.find_by_name(gets.chomp)
        artist.songs.each { |song| puts "#{artist.name} - #{song.name} - #{song.genre.name}" }
      when "list genre"
        genre = Genre.find_by_name(gets.chomp)
        genre.songs.each { |song| puts "#{song.artist.name} - #{song.name} - #{genre.name}" }
      when "exit"
        break
      else
        next
      end
    end
  end
end
