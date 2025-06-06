
class TwelveDays
    def self.song
        song = File.expand_path('song.txt', __dir__)
        IO.read(song)
    end
end