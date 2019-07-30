class MusicImporter

  attr_reader :path, :files

  def initialize(path)
    @path = path
  end

  def files
    @files =  Dir[@path + "/*"]

    cut_files = @files.map do |file|
      file.split("/")[-1]
    end

    @files = cut_files
    return cut_files
  end

  def import
    files.each do |file|
      Song.create_from_filename(file)
    end
  end
end
