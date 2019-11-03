require_relative "concerns/findable"

class CommonObject
  extend Concerns::Findable
  attr_accessor :name
  def initialize(name)
    @name = name
    @saved = false
  end

  def save
    unless @saved
      self.class.all << self
      @saved = true
    end
  end

  def self.create(name)
    obj = self.new(name)
    obj.save
    obj
  end
end
