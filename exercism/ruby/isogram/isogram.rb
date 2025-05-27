class Isogram
    def self.isogram?(input)
        cleaned = input.downcase.gsub(/[-\s]/, "")
        cleaned.chars.uniq.length == cleaned.length
    end
end