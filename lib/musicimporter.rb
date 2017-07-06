class MusicImporter

  attr_accessor :path
  @@filenames = []

  def initialize(path)
    @path = path
  end

  def files
    Dir.entries(@path).select do |filename|
      filename.include?(".mp3")
    end
  end

  def import
    self.files.each do |file|
      Song.create_from_filename(file)
    end
  end

end
