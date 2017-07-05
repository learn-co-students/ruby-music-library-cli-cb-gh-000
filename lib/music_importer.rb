class MusicImporter

  attr_reader :path

  def initialize(path)
    @path = path
  end

  def files
    Dir.entries(self.path).select do |filename|
      filename.end_with?(".mp3")
    end
  end

  def import
    self.files.each do |file|
      Song.create_from_filename(file)
    end
  end
end