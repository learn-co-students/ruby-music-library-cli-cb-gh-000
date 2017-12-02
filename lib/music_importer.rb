require_relative "song"

class MusicImporter
  attr_reader :path, :files, :library
  def initialize(path)
    @path = path
    @files = Dir["#{@path}/*"].map { |e| e.split("/")[-1] }
  end
  def import
    @library = @files.map { |e| Song.create_from_filename(e) }
  end
end
