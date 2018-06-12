class MusicLibraryController

	attr_accessor :path, :files, :artists

	def initialize(path = "./db/mp3s")
		@path = path
		new = MusicImporter.new(path)
		new.import
	end 
	
	def call 
		mess = [ "Welcome to your music library!", "To list all of your songs, enter 'list songs'.", "To list all of the artists in your library, enter 'list artists'.", "To list all of the genres in your library, enter 'list genres'.", "To list all of the songs by a particular artist, enter 'list artist'.", "To list all of the songs of a particular genre, enter 'list genre'.", "To play a song, enter 'play song'.", "To quit, type 'exit'.", "What would you like to do?"]
		mess.each { |words| puts words }
		
		query = nil
		while query != "exit" do
			query = gets.strip
			if query == "list songs"
				self.list_songs
			elsif query == "list artists"
				self.list_artists
			elsif query == "list genres"
				self.list_genres
			elsif query == "list artist"
				self.list_songs_by_artist
			elsif query == "list genre"
				self.list_songs_by_genre
			elsif query == "play song"
				self.play_song
			end
		end 
	end 
	
	def list_songs 
		path = @path 	
		p = path+"/*.mp3"
		self.files = []
		Dir[p].each do |element| 
			element.slice!(path+"/") 
			element.slice!(".mp3")
			self.files << element
		end 
		new = self.files.sort_by { |element| element.split(" - ")[1] }
		new.each.with_index(1) { |value, index| puts "#{index}. #{value}" }
	end
	
	def list_artists
		new = Artist.all.sort_by { |artist| artist.name }
		new.each.with_index(1) { |value, index| puts "#{index}. #{value.name}" }	
	end 
	
	def list_genres
		new = Genre.all.sort_by { |artist| artist.name }
		new.each.with_index(1) { |value, index| puts "#{index}. #{value.name}" }	
	end 
	
	def list_songs_by_artist
		puts "Please enter the name of an artist:"
		name = gets.strip
		new = Artist.find_by_name(name)
		if new != nil
			list = new.songs.sort_by {|song| song.name}
			list.each.with_index(1) { |song, index| puts "#{index}. #{song.name} - #{song.genre.name}" }
		end 
	end 
	
	def list_songs_by_genre
		puts "Please enter the name of a genre:"
		name = gets.strip
		new = Genre.find_by_name(name)
		if new != nil
			list = new.songs.sort_by {|song| song.name}
			list.each.with_index(1) { |song, index| puts "#{index}. #{song.artist.name} - #{song.name}" }
		end 
	end 	
	
	def play_song
		puts "Which song number would you like to play?"
		number = gets.strip.to_i
		list = Song.all.sort_by { |song| song.name }
		if number > 0 && number <= Song.all.count
			puts "Playing #{list[number-1].name} by #{list[number-1].artist.name}"
		end 
	end
	
end 
