require_relative "song.rb"

class MusicImporter

  attr_accessor :path

  def initialize(path)
    @path = path
  end

  def files
    Dir[path + "/*.mp3"].map do |filepath|
      File.basename(filepath)
    end
  end

  def import
    files.each do |filename|
      Song.create_from_filename(filename)
    end
  end

end
