class MusicLibraryController 

    attr_accessor :path

    def initialize(path='./db/mp3s')
        @path = path 
        MusicImporter.new(path).import
    end

    def call 

        user_input = String.new(" ")

        while user_input != "exit"
        

        puts "Welcome to your music library!"
        puts "To list all of your songs, enter 'list songs'."
        puts "To list all of the artists in your library, enter 'list artists'."
        puts "To list all of the genres in your library, enter 'list genres'."
        puts "To list all of the songs by a particular artist, enter 'list artist'."
        puts "To list all of the songs of a particular genre, enter 'list genre'."
        puts "To play a song, enter 'play song'."
        puts "To quit, type 'exit'."
        puts "What would you like to do?"

        user_input = gets.strip  
        
        case user_input
        when 'list songs'
            list_songs
        when 'list artists'
            list_artists
        when 'list genres'
            list_genres
        when 'list artist'
            list_songs_by_artist
        when 'list genre'
            list_songs_by_genre
        when 'play song'
            play_song
        else
            "Please type in a valid input"
        end
    end
end

    def unik_lib(klass = Song)
        unique_lib = klass.all.collect{|object|object if object.class == klass }
        unique_lib = unique_lib.delete_if {|object|object==nil}
        unique_lib.uniq
    end

    def list_songs       
        list_of_songs = self.unik_lib.sort_by {|song| song.name}
        list_of_songs.each do |song|
            puts "#{list_of_songs.index(song) + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
        end
    end

    def list_artists
        Artist.all.sort {|a, b| a.name <=> b.name}.each.with_index(1) do |a, i|
            puts "#{i}. #{a.name}"
        end
    end

    def list_genres
        list_of_genres = self.unik_lib.sort_by {|song| song.genre.name}
        genres = list_of_genres.collect {|song| "#{song.genre.name}"}.uniq 
        genres.each {|genre| puts "#{genres.index(genre) + 1}. #{genre}"}
        #Genre.all.sort {|a, b| a.name <=> b.name}.each.with_index(1) do |g, i|
        #    puts "#{i}. #{g.name}"
        #end
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        user_input = gets.strip

        if artist = Artist.find_by_name(user_input)
            artist_songs = artist.songs.sort {|a, b| a.name <=> b.name}
            artist_songs.each.with_index do |song, index|
                puts "#{index + 1}. #{song.name} - #{song.genre.name}"
            end
        end
    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        user_input = gets.strip

        if genre = Genre.find_by_name(user_input)
            genre.songs.sort {|a, b| a.name <=> b.name}.each.with_index do |song, index|
                puts "#{index + 1}. #{song.artist.name} - #{song.name}"
            end
        end
    end

    def play_song
        puts "Which song number would you like to play?"

        input = gets.strip.to_i
        if (1..self.unik_lib.length).include?(input)
            song = self.unik_lib.sort{|a, b| a.name <=> b.name}[input - 1]
        end
        puts "Playing #{song.name} by #{song.artist.name}" unless song == nil
    end




end
