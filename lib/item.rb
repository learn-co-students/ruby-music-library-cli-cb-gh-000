require 'pry'

class Item

  @@all = []

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def self.create(name)
    new_element = self.new(name)  # NOTE: this SELF is the child class, not Item :) ... (Just like in the Modules)
    new_element.save
    new_element
  end

  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def save
    @@all << self
  end

end