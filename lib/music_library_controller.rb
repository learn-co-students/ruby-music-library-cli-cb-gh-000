require 'pry'

class MusicLibraryController

  attr_reader :music_importer, :songs

  def initialize(path = "./db/mp3s")
    @music_importer = MusicImporter.new(path)
    @music_importer.import
    @songs = Song.all
    @songs = @songs.sort do |s1, s2|
      s1.artist.name <=> s2.artist.name
    end
  end

  def call
    print ">>> "
    input = gets.chomp
    while input != "exit" do

      case input
      when "list songs"
        self.songs.each_with_index do |song, i|
          puts "#{i + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
        end
      when "list artists"
        self.songs.each_with_index do |song, i|
          puts "#{song.artist.name}"
        end
      when "list genres"
        self.songs.each_with_index do |song, i|
          puts "#{song.genre.name}"
        end
      when "play song"
        print "index >>> "
        n = gets
        song = self.songs[(n.to_i - 1)]
        puts "Playing #{song.artist.name} - #{song.name} - #{song.genre.name}"
      when "list artist"
        print "artist >>> "
        n = gets.chomp
        songs = self.songs.select {|s| s.artist.name == n}
        songs.each do |song|
          puts "#{song.artist.name} - #{song.name} - #{song.genre.name}"
        end
      when "list genre"
        print "genre >>> "
        n = gets.chomp
        songs = self.songs.select {|s| s.genre.name == n}
        songs.each do |song|
          puts "#{song.artist.name} - #{song.name} - #{song.genre.name}"
        end
      end
          
      print ">>> "
      input = gets.chomp
    end
  end
  
end