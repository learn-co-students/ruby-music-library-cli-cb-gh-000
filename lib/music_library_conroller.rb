
class MusicLibraryController

	attr_accessor :path
	def initialize(path = "./db/mp3s")
		@path = path
		@music_importer = MusicImporter.new(path)
		@music_importer.import
	end

	def call
		input = ""
		while input != "exit" do
			puts ("Welcome to your music library!")
			puts ("To list all of your songs, enter 'list songs'.")
			puts ("To list all of the artists in your library, enter 'list artists'.")
			puts ("To list all of the genres in your library, enter 'list genres'.")
			puts ("To list all of the songs by a particular artist, enter 'list artist'.")
			puts ("To list all of the songs of a particular genre, enter 'list genre'.")
			puts ("To play a song, enter 'play song'.")
			puts ("To quit, type 'exit'.")
			puts ("What would you like to do?")
			input = gets.strip
			case input
			when "list songs"
				self.list_songs
			when "list genres"
				self.list_genres
			when "exit"
				break
			when "list artists"
				self.list_artists
			when "list artist"
				self.list_songs_by_artist
			when 'list genre'
				self.list_songs_by_genre
			when "play song"
				self.play_song
			end
		end
	end

	def list_songs
		songs = Song.all.sort {|song1, song2| song1.name <=> song2.name}
		songs.each_with_index {|song, index| puts "#{index + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"}
		#songs
	end

	def list_artists
		artists = Artist.all.sort {|artist1, artist2| artist1.name <=> artist2.name}
		artists.each_with_index {|artist, index| puts "#{index + 1}. #{artist.name}"}
	end

	def list_genres
		genres = Genre.all.sort {|genre1, genre2| genre1.name <=> genre2.name}
		genres.each_with_index {|genre, index| puts "#{index + 1}. #{genre.name}"}
	end

	def list_songs_by_artist
		puts "Please enter the name of an artist:"
		name = gets
		Artist.find_or_create_by_name(name).songs.sort {|song1, song2| song1.name <=> song2.name}.each_with_index do |song, index|
			genre = song.genre
			puts (index + 1).to_s + ". " + song.name + " - " + genre.name
			break
		end
	end

	def list_songs_by_genre
		puts "Please enter the name of a genre:"
		name = gets
		Genre.find_or_create_by_name(name).songs.sort {|song1, song2| song1.name <=> song2.name}.each_with_index do |song, index|
			artist = song.artist
			puts (index + 1).to_s + ". " + artist.name + " - " + song.name
		end
	end

	def play_song
		puts "Which song number would you like to play?"
		songs = Song.all.sort {|song1, song2| song1.name <=> song2.name}
		number = gets.to_i
		if number >= 1 && number < (songs.size)
			song = songs[number - 1]
			puts "Playing #{song.name} by #{song.artist.name}" unless !song
		end

	end
end
