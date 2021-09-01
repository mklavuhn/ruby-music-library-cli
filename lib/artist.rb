class Artist

    extend Concerns::Findable

    attr_accessor :name 
    attr_reader :songs

    @@all = []

    def initialize(name)
        @name = name 
        @songs = []
    end

    def self.all
        @@all
    end

    def save
        @@all << self 
    end

    def self.destroy_all
        @@all.clear 
    end

    def self.create(name)
        artist = self.new(name)
        artist.save
        return artist 
    end

    def songs 
        Song.all.select {|song| song.artist == self}.uniq
    end

    def add_song(song)
        song.artist = self unless song.artist == self
        @songs << song unless @songs.include?(song) == false
    end

    def genres
        self.songs.collect {|song| song.genre}.uniq
    end








end
