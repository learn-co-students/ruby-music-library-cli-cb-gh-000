class MusicImporter

  def self.parse filename
    artist_name,song_name, genre_name = filename.split(" - ")
    genre_name = genre_name.split(".")[0]
    {
      song_name: song_name,
      artist_name: artist_name,
      genre_name: genre_name
    }
  end

  attr_reader :path, :files

  def initialize path
    @path = path
    @files = Dir.entries(@path).select{|song| song.size > 5}
  end

  def import
    @files.each do |file|
      Song.create_from_filename file
    end
  end

end
