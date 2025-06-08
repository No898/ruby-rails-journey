class House
	@@count = 0

	def self.count
		@@count
	end

	def self.report_count_of_instances
		"There are #{count} of instances of the #{name} class"
	end
	attr_accessor :color, :style

	def initialize(color, style)
		@color = color
		@style = style
		@@count += 1 
	end

	def details
		"This is a #{color} #{style} house"
	end
end

house = House.new("blue", "modern")
puts house.details

puts House.report_count_of_instances
puts House.count
house = House.new("blue", "modern")
puts house.color
puts house.style
puts House.count