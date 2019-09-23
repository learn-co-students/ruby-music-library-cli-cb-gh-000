class MusicImporter
  attr_accessor :path, :files

  def initialize(path)
    @path = path
  end

  def path
    @path
  end

  def files
    @files = Dir.entries(path).select { |filename| filename.end_with?(".mp3") }
  end

  def import
    files.each {|f| Song.create_from_filename(f)}
  end
end
