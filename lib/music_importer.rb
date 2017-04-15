class MusicImporter
  attr_reader :path

  def initialize(path)
    @path = path
  end

  def files
    filenames = Dir["#{@path}/*"]

    normalized_filenames = []

    filenames.each do |filename|
      normalized_filenames << filename.gsub("#{@path}/","")
    end

    normalized_filenames
  end

  def import
    new_songs = []

    self.files.each do |filename|
      new_songs << Song.create_from_filename(filename)
    end

    new_songs
  end
end
