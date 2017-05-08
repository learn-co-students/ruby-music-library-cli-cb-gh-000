class MusicImporter

  attr_reader :files, :path

  def initialize(path)
    @path = path
    @files = Dir.entries(path).select{ |file| !File.directory? file}
  end

  def import
    files.each { |file| Song.create_from_filename(file) }
  end

end
