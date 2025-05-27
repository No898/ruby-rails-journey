# exe.rb
BASE_DIR = "exercism/ruby"

def clear_screen
  if Gem.win_platform?
    system("cls")
  else
    system("clear")
  end
end

def choose(prompt, options)
  clear_screen
  puts prompt
  options.each_with_index { |opt, i| puts "#{i + 1}) #{opt}" }
  print "> "
  idx = gets.to_i - 1
  options[idx]
end

action = choose("Choose action:", ["test", "submit"])
selected_folder = choose("Choose folder:", Dir.children(BASE_DIR).select { |f| File.directory?(File.join(BASE_DIR, f)) })
folder_path = File.join(BASE_DIR, selected_folder)

if action == "test"
  files = Dir.glob(File.join(folder_path, "*_test.rb"))
else
  files = Dir.glob(File.join(folder_path, "*.rb")) - Dir.glob(File.join(folder_path, "*_test.rb"))
end

abort "No matching files." if files.empty?

selected_file = choose("Choose file:", files.map { |f| File.basename(f) })
file_path = File.join(folder_path, selected_file)

if action == "test"
  clear_screen
  puts "Running: ruby -r minitest/pride #{file_path}"
  exec("ruby", "-r", "minitest/pride", file_path)
else
  clear_screen
  puts "Submitting: exercism submit #{file_path}"
  exec("exercism", "submit", file_path)
end
