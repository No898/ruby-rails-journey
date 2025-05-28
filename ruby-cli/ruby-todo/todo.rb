require_relative "task"
require "json"

puts "Welcome in To-Do App"
puts "Write command (help if you need) :"

DATA_FILE = "tasks.json"

# load saved tasks from json file
def load_tasks
	return [] unless File.exist?(DATA_FILE)
	
	json = File.read(DATA_FILE)
	parsed = JSON.parse(json)
	parsed.map { |h| Task.new(h["text"], h["done"]) } # h is shortcut for hash
end
# Save tasks to json file
def save_tasks(tasks)
	data = tasks.map { |t| {text: t.text, done: t.done} }
	File.write(DATA_FILE, JSON.pretty_generate(data))
end

# load tasks from json file
tasks = load_tasks

# app
loop do 
    print "> "
    input = gets.chomp

    case input
    when "exit"
        puts "Goodbye!"
        break
    when "help"
    	puts <<~HELP
			Available commands:
			- add		: Add new task
			- list		: List all tasks
			- done		: Mark task as done
			- remove	: Remove task
			- clear		: Clear all tasks
			- exit		: Close app
		HELP

		when "add"
			puts "Write task description:"
			task_text = gets.chomp
			task = Task.new(task_text)
			tasks << task # add task to array
			save_tasks(tasks)
			puts "Task added"

		when "list"
			if tasks.empty?
				puts "List is empty"
			else
				puts "List of tasks:"
				tasks.each_with_index do |task, index|
					puts "#{index + 1}. #{task}"
			end
		end

		when "done"
			if tasks.empty?
				puts "List is empty"
			else
				puts "Write number of task to mark as DONE:"
				tasks.each_with_index do |task, index|
					puts "#{index + 1}. #{task}"
				end
				print "> "
				number = gets.chomp.to_i #read input, clear \n, convert to int

				if number.between?(1, tasks.size)
					tasks[number - 1].done = true
					save_tasks(tasks)
				puts "Task n. #{number} marked as done"
				else
					puts "Invalid task number"
				end
			end

		when "remove"
			if tasks.empty?
				puts "List is empty"
			else
				puts "Write number of task to REMOVE:"
				tasks.each_with_index do |task, index|
					puts "#{index + 1}. #{task}"
				end
				print "> "
				number = gets.chomp.to_i

				if number.between?(1, tasks.size)
					removed = tasks.delete_at(number - 1)
					save_tasks(tasks)
					puts "Removed: #{number}. #{removed}"
				else
					puts "Invalid task number"
				end
			end
		
		when "clear"
			if tasks.empty?
				puts "List is empty"
			else
				tasks.clear
				save_tasks(tasks)
				puts "All tasks cleared"
			end
		else
			puts "Unknown command"
	end
end
