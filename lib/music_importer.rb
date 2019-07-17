require 'pry'
class MusicImporter

  attr_accessor :path

  def initialize(path)
    @path = path
    @files = []
  end

  def files
    filepaths = Dir.glob("#{self.path}/*.mp3")
    filepaths.each do |filepath|
      @files << File.basename(filepath)
    end
    @files
  end

  def import
    self.files.each do |filename|
      song = Song.create_from_filename(filename)
    end
  end

end
