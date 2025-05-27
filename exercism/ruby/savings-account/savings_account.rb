module SavingsAccount
  def self.interest_rate(balance)
    if balance < 0
      3.213
    elsif balance < 1000
      0.5
    elsif balance < 5000
      1.621
    else
      2.475
    end
  end

  def self.annual_balance_update(balance)
    rate = interest_rate(balance)
    if balance < 0
      balance - (balance.abs * rate / 100)
    else
      balance + (balance * rate / 100)
    end
  end
  

  def self.years_before_desired_balance(balance, desired_balance)
    years = 0
    while balance < desired_balance
      balance = annual_balance_update(balance)
      years += 1
    end
    years
  end
end