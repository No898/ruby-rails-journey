
module EliudsEggs
    def self.egg_count(n)
        bits = []
        while n > 0
            bits << n % 2
            n /= 2
        end
        bits.sum
    end

end