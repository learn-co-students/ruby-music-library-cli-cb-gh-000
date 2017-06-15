class MusicImporter

  attr_accessor :path

  def initialize(path)
    @path = path
    @files = []
  end

  def files
    @files = Dir.entries(@path).select { |e| !File.directory?(e) }
  end

  def import
    files.each { |file| Song.create_from_filename(file) }
  end
end
