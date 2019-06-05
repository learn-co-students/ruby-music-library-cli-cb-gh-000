class MusicImporter
  attr_accessor :path, :files

  def initialize(path)
    @path = path
    @files = Dir.entries(@path).select {|e| e.include?(".mp3")}
  end

  def import
    @files.each {|file| Song.create_from_filename(file)}
  end
end
