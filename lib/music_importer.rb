class MusicImporter
  attr_accessor :path, :files

  def initialize(path)
    if Dir.exist?(path)
      @path = path
      @files = Dir.entries(path).select { |filename| filename.end_with?(".mp3") }
    end
  end

  def import
    @files.each { |filename| Song.create_from_filename(filename) }
  end
end
