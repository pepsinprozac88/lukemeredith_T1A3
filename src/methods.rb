def read(filename)   # Reads back the note to the terminal screen.
   File.open(filename).each do |text|
   puts text
   end
end

def create(filename, content) # Creates a new note, saves the note in .txt format to local directory.
   File.open(filename, "w") do |file|     
   file.write(content)
   end
end

def line() # simple line break for aesthetics, I got sick of drawing lines over and over again.
   pastel = Pastel.new
   puts pastel.yellow.underline"________________________________________________________________________________________"
end

def instructions(option, header) # prints the notes list and accompanying instructions to the screen.
   pastel = Pastel.new
   system ('clear')
   puts pastel.yellow("-- #{header} Note --")
   puts "\n"
   puts pastel.yellow.underline("\nNote List:_____________________________________________________________________________")
   puts "\n"
   puts Dir.glob("*.txt")
   puts "\n"
   puts pastel.yellow("\nWhich note entry would you like to #{option}?")
   puts pastel.yellow("\nType in the note's title below, and don't worry about the file extension (.txt) or the underscore!")
   puts pastel.yellow("(NOTE: Leave blank and press 'Enter' to go back)")
   puts "\n"
end

def back() # a function that allows the user to return to the main menu when they so choose.
   pastel = Pastel.new
   prompt = TTY::Prompt.new(active_color: :yellow)
   puts "\n"
   choose2nd = %w(Back)
   choice2nd = prompt.select("Go Back?", choose2nd).to_s         
   case choice2nd
   when "Back"
      puts "\n"               
   else 
   puts pastel.red("Error!")
   end
end