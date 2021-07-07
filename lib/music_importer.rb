

class MusicImporter
  attr_accessor :path

  def initialize(file_path)
    @path = file_path
  end

  def files
    raw_files = []
    Dir[path + "/*"].collect{|file| raw_files << file.split("/").last}
    raw_files
  end

  def import
    self.files.each{|file| Song.create_from_filename(file)}
  end


end
