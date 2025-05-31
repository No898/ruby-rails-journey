
class Luhn
    def self.valid?(number)
        number=number.gsub(" ","") # remove spaces
        return false if number.length <2 # return false if the number is less than 2
        return false unless number.match?(/^\d+$/) # return false if the number is not a digit

        digits = number.chars.reverse.map(&:to_i) # convert to string,reverse and convert to integer
        sum = digits.each_with_index.sum do |digit, index|
            if index.odd? # if the index is odd, multiply the digit by 2
                d = digit * 2
                d > 9 ? d - 9 : d
            else
                digit
            end
        end
    sum % 10 == 0 # if the sum is divisible by 10, return true
  end
end