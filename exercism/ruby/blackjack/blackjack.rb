module Blackjack
  def self.parse_card(card)
      case card
      when "ace" then 11
      when "two" then 2
      when "three" then 3
      when "four" then 4
      when "five" then 5
      when "six" then 6
      when "seven" then 7
      when "eight" then 8
      when "nine" then 9
      when "ten" then 10
      when "jack" then 10
      when "queen" then 10
      when "king" then 10
      else 0
    end
  end

  def self.card_range(card1, card2)
    sum = parse_card(card1) + parse_card(card2)
    case sum
    when 4..11 then "low"
    when  12..16 then "mid"
    when 17..20 then "high"
    when  21 then "blackjack"
    else "wrong cards"
    end

  end

  def self.first_turn(card1, card2, dealer_card)
    sum = parse_card(card1) + parse_card(card2)
  
    if card1 == "ace" && card2 == "ace"
      "P"
    elsif sum == 21
      if ["ten", "jack", "queen", "king", "ace"].include?(dealer_card)
        "S"
      else
        "W"
      end
    elsif (17..20).include?(sum)
      "S"
    elsif (12..16).include?(sum)
      if parse_card(dealer_card) >= 7
        "H"
      else
        "S"
      end
    else
      "H"
    end
  end
end
# def self.first_turn(card1, card2, dealer_card)
#   player_score = parse_card(card1) + parse_card(card2)
#   dealer_score = parse_card(dealer_card)
#
#   return "P" if card1 == "ace" && card2 == "ace"
#
#   if player_score == 21
#     return STRONG_DEALER_CARDS.include?(dealer_card) ? "S" : "W"
#   end
#
#   return "S" if (17..20).include?(player_score)
#
#   if (12..16).include?(player_score)
#     return dealer_score >= 7 ? "H" : "S"
#   end
#
#   "H"
# end


# S stand
# H hit
# P split
# W Auto win