class MusicImporter
  attr_accessor :path, :files
  @@all = []
  def initialize(file_path)
    @path = file_path
    @files = Dir[@path+"/*.mp3"].collect{|filename| filename.split('/')[-1]}
  end
  def import
    @files.each{|filename| Song.create_from_filename(filename)}
  end
end