class MusicLibraryController

  def self.print_usage
    puts """
    Usage:
      list songs|artists|genres
      list artist|genre
        <name>
      play song
        <song number>

    exit to close
    """
  end

  # TODO: should use symbols instead of strings.
  def self.all_of(what, sort = true)
    all = nil
    case what
      when "songs"
        all = Song.all
      when "artists"
        all = Artist.all
      when "genres"
        all = Genre.all
    end
    all.sort { |a, b| a.to_s <=> b.to_s } if sort
  end


  attr_reader :path, :music_importer

  def initialize(path = "./db/mp3s")
    @path = path
    @music_importer = MusicImporter.new(path)
    @music_importer.import
  end

  def call
    self.class.print_usage
    command = gets.strip

    until command == "exit"  # NOTE: in this case is equivalent to command.eql?("exit")
      if result = command.match(/list (songs|artists|genres)/)
        what = result.captures.first
        list(what)

      elsif result = command.match(/list (artist|genre)/)
        what = result.captures.first
        puts "Enter name of #{what}:"
        name = gets.strip
        list_songs_of("#{what}s", name)

      elsif command.match(/play song/)
        puts "Enter number of song to play (songs are sorted alphabetically by file name):"
        index = gets.strip.to_i - 1
        play_song_index(index)

      end
      puts "Enter new command:"
      command = gets.strip
    end
  end

  def list(what)
    puts "Listing all #{what}"
    all = self.class.all_of(what)
    if what == "songs"
      all.each_with_index { |song, i| puts "#{i + 1}. #{song.to_s}" }
    else
      all.each_with_index { |e, i| puts "#{i + 1}. #{e.name}" }
    end
  end

  def list_songs_of(what, name)
    puts "Listing all songs with #{what} name of #{name}"
    songs = self.class.all_of("songs")
    if what == "artists"  # TODO: there should be a better way of doing this but for now....
      songs = songs.select { |song| song.artist.name == name }
    elsif what == "genres"
      songs = songs.select { |song| song.genre.name == name }
    end
    songs.each_with_index { |song, i| puts "#{i + 1}. #{song.to_s}" }
  end

  def play_song_index(index)
    song = self.class.all_of("songs")[index]
    puts "Playing #{song.to_s}"
  end

end
