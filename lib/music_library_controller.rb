class MusicLibraryController

  attr_reader :path

  def initialize(path = "./db/mp3s")
    MusicImporter.new(path).import
  end

  def call

    user = nil
    while user != "exit"
      user = gets.strip
      if user == "list songs"
        Song.all.each.with_index(1) {|song, index| puts "#{index}. #{song.artist.name} - #{song.name} - #{song.genre.name}"}
      elsif user == "list artists"
        Artist.all.each {|artist| puts artist.name}
      elsif user == "list genres"
        Genre.all.each {|genres| puts genres.name}
      elsif user == "play song"
        user = gets.strip
        song = Song.all[user.to_i-1]
        puts "Playing #{song.artist.name} - #{song.name} - #{song.genre.name}"
      elsif user == "list artist"
        user = gets.strip
        artist = Artist.find_by_name(user)
        artist.songs.each {|song| puts "#{artist.name} - #{song.name} - #{song.genre.name}"}
      elsif user == "list genre"
        user = gets.strip
        genre = Genre.find_by_name(user)
        genre.songs.each {|song| puts "#{song.artist.name} - #{song.name} - #{song.genre.name}"}
      end
        # ---> while
    end

  end

end
