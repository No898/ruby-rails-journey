class TwoFer
    def self.two_fer(name = nil)
      name = "you" if name.nil? || name.strip.empty?
      "One for #{name}, one for me."
    end
  end