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
  loop do
    clear_screen
    puts prompt
    puts "0) Back" unless prompt.downcase == "choose action:"
    options.each_with_index { |opt, i| puts "#{i + 1}) #{opt}" }
    print "> "
    input = gets.to_i

    return :back if input == 0 && prompt.downcase != "choose action:"
    return options[input - 1] if input.between?(1, options.size)
  end
end

loop do
  action = choose("Choose action:", ["test", "submit"])
  break if action == :back

  loop do
    selected_folder = choose("Choose folder:", Dir.children(BASE_DIR).select { |f| File.directory?(File.join(BASE_DIR, f)) }.sort)
    break if selected_folder == :back

    folder_path = File.join(BASE_DIR, selected_folder)

    files = if action == "test"
      Dir.glob(File.join(folder_path, "*_test.rb"))
    else
      Dir.glob(File.join(folder_path, "*.rb")) - Dir.glob(File.join(folder_path, "*_test.rb"))
    end

    if files.empty?
      puts "No matching files. Press Enter to go back."
      gets
      next
    end

    loop do
      selected_file = choose("Choose file:", files.map { |f| File.basename(f) })
      break if selected_file == :back

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
    end
  end
end
