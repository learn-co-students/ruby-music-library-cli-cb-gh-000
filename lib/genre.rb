class Genre
  include Concerns::CommonFunctions::InstanceMethods
  include Concerns::HasManyCommon::InstanceMethods
  extend Concerns::CommonFunctions::ClassMethods
  extend Concerns::Findable

  attr_accessor :name
  attr_reader :songs
  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def add_song(song)
    super(song, "genre")
  end

  def artists
    self.has_many_though("artist")
  end

  def self.all
    @@all
  end
end
