class Song 


    attr_accessor :name 
    attr_reader :artist, :genre

    @@all = []

    def initialize(name, artist = nil, genre = nil)
        @name = name 
        self.artist=(artist) if artist != nil
        self.genre=(genre) if genre != nil
        save 
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
        song = self.new(name)
        song.save
        return song 
    end

    def artist=(artist) 
        @artist = artist
        self.artist.add_song(self)
    end

    def genre=(genre)
        @genre = genre 
        self.genre.add_song(self)
    end

    def self.find_by_name(name)
        self.all.uniq!.detect {|song| song.name == name}
    end

    def self.find_or_create_by_name(name)
        song = self.find_by_name(name)
        if song == nil 
            self.create(name)
        else
            song
        end
    end

    def self.new_from_filename(filename)
        file = filename.gsub(/.mp3/, '')
        song_file = file.split(" - ")
        song_name = song_file[1]
        song_artist = Artist.find_or_create_by_name(song_file[0])
        song_genre = Genre.find_or_create_by_name(song_file[2])
        song = self.new(song_name, song_artist, song_genre)
    end

    def self.create_from_filename(filename)
        song = self.new_from_filename(filename)
        song.save
        song
    end







end