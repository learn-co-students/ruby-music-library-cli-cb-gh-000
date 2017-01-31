class MusicImporter
  attr_reader :path

  def initialize(path)
    @path = path
  end

  def files
    mp3s = []
    Find.find(path).each do |file_path|
      mp3s << file_path.split("/").last if file_path.end_with?(".mp3")
    end
    mp3s
  end

  def import
    self.files.each do |filename|
      Song.create_from_filename(filename)
    end
  end
end
