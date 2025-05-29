class SimpleCalculator
  ALLOWED_OPERATIONS = ['+', '/', '*'].freeze
  class UnsupportedOperation < StandardError; end # a name for the error, for better readability


  def self.calculate(first_operand, second_operand, operation)
    raise UnsupportedOperation, 'Invalid operation' unless ALLOWED_OPERATIONS.include?(operation)

    raise ArgumentError, 'Invalid operand' unless first_operand.is_a?(Integer) && second_operand.is_a?(Integer)

    case operation
    when '+'
      "#{first_operand} + #{second_operand} = #{first_operand + second_operand}"
    when '/'
      begin
        "#{first_operand} / #{second_operand} = #{first_operand / second_operand}"
      rescue ZeroDivisionError
        "Division by zero is not allowed."
      end
    when '*'
      "#{first_operand} * #{second_operand} = #{first_operand * second_operand}"
    end
  end
end
