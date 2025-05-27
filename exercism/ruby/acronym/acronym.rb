
class Acronym
    def self.abbreviate(phrase)
        cleaned = phrase.gsub(/[^a-zA-Z\- ]/,'')
        words = cleaned.split(/[j\s\-]+/)
        words.map {|word| word[0].upcase}.join
    end
end