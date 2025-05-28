class Phrase
    def initialize(text)
      @text = text
    end
  
    def word_count
      words = @text.downcase.scan(/\b[\w']+\b/)
      words.map! { |w| w.gsub(/\A'+|'+\z/, '') } 
      counts = Hash.new(0)
      words.each { |word| counts[word] += 1 }
      counts
    end
  end
  