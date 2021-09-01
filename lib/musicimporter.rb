class MusicImporter

    attr_accessor :path, :files 

    def initialize(path)
        @path = path 
    end

    def files
        Dir.chdir(@path) do |path|
            Dir.glob("*.mp3")
        end
    end

    def import 
        files.each do |file|
            s = Song.create_from_filename(file)
        end
    end


end
