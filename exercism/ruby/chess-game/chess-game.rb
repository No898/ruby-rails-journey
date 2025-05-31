module Chess
    RANKS = 1..8
    FILES = 'A'..'H'
  
    def self.valid_square?(rank, file)
      RANKS.include?(rank) && FILES.include?(file)
    end
  
    def self.nick_name(first_name, last_name)
      (first_name[0,2] + last_name[-2,2]).upcase
    end
  
    def self.move_message(first_name, last_name, square)
      file = square[0]
      rank = square[1..-1].to_i
      nick = nick_name(first_name, last_name)
      if valid_square?(rank, file)
        "#{nick} moved to #{square}"
      else
        "#{nick} attempted to move to #{square}, but that is not a valid square"
      end
    end
  end