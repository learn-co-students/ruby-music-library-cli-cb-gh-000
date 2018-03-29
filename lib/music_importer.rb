
class MusicImporter
attr_reader :path, :files

def initialize(path)
  @path = path
end

def files
  files ||= Dir["#{@path}/*.mp3"].collect{|x| x.sub("#{@path}/",'')}
end

def import
  files.each do |x|
    Song.create_from_filename(x)
  end
end

end
