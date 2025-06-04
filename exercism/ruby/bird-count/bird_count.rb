class BirdCount
  def self.last_week
   [0, 2, 5, 3, 7, 8, 4]
  end

  def initialize(birds_per_day)
    unless birds_per_day.is_a?(Array)
      raise ArgumentError, "birds_per_day must be an array"
    end
    @birds_per_day = birds_per_day
  end

  def yesterday
     @birds_per_day[-2]
  
  end

  def total 
    @birds_per_day.sum
  end

  def busy_days
   @birds_per_day.count { |bird| bird >= 5 }
  end

  def day_without_birds?
    @birds_per_day.count(0) > 0
  end
end
