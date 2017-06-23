
class MusicImporter

  attr_reader :path

  def initialize path
    @path = path
  end

  def files
    Dir[File.expand_path '*.mp3', @path].map do |filename|
      File.basename filename
    end
  end

  def import
    files.map do |filename|
      Song.create_from_filename filename
    end
  end
end
