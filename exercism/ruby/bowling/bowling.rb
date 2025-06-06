
class Game
  class BowlingError < StandardError; end

  MAX_FRAMES = 10
  MAX_PINS = 10

  def initialize
    @rolls = []
  end

  def roll(pins)
    if pins < 0 || pins > MAX_PINS
      raise BowlingError, "Invalid roll: #{pins}"
    end
    @rolls << pins
  end

  def score
    validate_last_frame!
  
    score = 0
    roll_index = 0
  
    (MAX_FRAMES - 1).times do
      if @rolls[roll_index] == MAX_PINS # strike
        score += MAX_PINS + @rolls[roll_index + 1] + @rolls[roll_index + 2]
        roll_index += 1
      elsif @rolls[roll_index] + @rolls[roll_index + 1] == MAX_PINS # spare
        score += MAX_PINS + @rolls[roll_index + 2]
        roll_index += 2
      else
        score += @rolls[roll_index] + @rolls[roll_index + 1] # open frame
        roll_index += 2
      end
    end
  
    # last_throw_index
    score += @rolls[roll_index].to_i + @rolls[roll_index + 1].to_i + @rolls[roll_index + 2].to_i
  
    score
  end
  
  def validate_last_frame!
    roll_index = 0
    (MAX_FRAMES - 1).times do
      roll_index += @rolls[roll_index] == MAX_PINS ? 1 : 2
    end
  
    remaining = @rolls[roll_index..]
  
    first = remaining[0].to_i
    second = remaining[1].to_i
    third = remaining[2]
  
    if first == MAX_PINS || first + second == MAX_PINS
      raise BowlingError, "10th frame must have 3 rolls after strike/spare" if third.nil?
    else
      raise BowlingError, "Open 10th frame must have exactly 2 rolls" unless remaining.size == 2
    end
  end
end