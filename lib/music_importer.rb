class MusicImporter

  attr_reader :path

  def initialize(path)
    @path = path
  end

  def files
    dty_files = Dir[@path + "/*mp3"]
    dty_files.collect {|file| File.basename(file)}
  end

  def import
    self.files.each {|filename| Song.create_from_filename(filename)}
  end


end
