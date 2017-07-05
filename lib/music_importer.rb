class MusicImporter

  attr_reader :path

  def initialize(path)
    @path = path
  end

  # Returns all the filenames, with the .mp3 subfix.
  def files
    # https://stackoverflow.com/questions/1755665/get-names-of-all-files-from-a-folder-with-ruby
    Dir["#{@path}/*.mp3"].collect { |filepath| filepath.split("/").last }
  end

  def import
    self.files.each { |filename| Song.create_from_filename(filename) }
  end

end
