class Genre

	attr_accessor :name, :songs
	
	@@all = []
	
	extend Concerns::Findable
	
	def initialize(name)
		@name = name 
		self.songs = []
		@artist_list = []
		#self.class.all << self 
	end 
	
	def artists
		@artist_list
	end 
	
	def self.all
		@@all 
	end
	
	def save
		self.class.all << self
	end 
	
	def self.destroy_all
		@@all.clear
	end 
	
	def self.create(name)
		new = self.new(name)
		new.save
		new 
	end 

end 
