class MusicImporter
  attr_reader :path
  def initialize(path)
    @path = path
  end

  def files
    Dir["#{self.path}/**/*.mp3"].map {|f| f.gsub("#{self.path}/","")}.sort
  end

  def import
    self.files.each {|f| Song.create_from_filename(f)}
  end

end
