class Task
	attr_accessor :text, :done
	
	def initialize(text, done = false)
		@text = text
		@done = done
	end

def to_s
	status = done ? "\e[32m Done       \e[0m - #{text}" :
		"\e[33m In progress\e[0m - #{text}"
	end

end
