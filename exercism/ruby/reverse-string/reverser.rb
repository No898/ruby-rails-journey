module Reverser
    def self.reverse(string)
        string.reverse
    end
end

puts Reverser.reverse("stressed")
puts Reverser.reverse("strops")
puts Reverser.reverse("racecar")

# def self.nazev = metodu zavolas na modul nebo tridu
# def nazev = metodu zavolas na instanci