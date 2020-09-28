require 'date'
require 'pastel'
require 'tty-prompt'

prompt = TTY::Prompt.new(active_color: :green)
pastel = Pastel.new

def read(filename)
   File.open(filename).each do |text|
   puts text
   end
end

def create(filename, content)
   File.open(filename, "w") do |file|     
   file.write(content)
   end
end

entries = []

puts pastel.green("\n\n\n
                           SUPER                                                    
   ▀███▄   ▀███▀ ▄▄█▀▀██▄ ███▀▀██▀▀██████▀▀▀███ ▄█▀▀▀█▄██ 
     ███▄    █ ▄██▀    ▀██▄▀   ██   ▀█ ██    ▀█▄██    ▀██ 
     █ ███   █ ██▀      ▀██    ██      ██   █  ▀███▄   ██ 
     █  ▀██▄ █ ██        ██    ██      ██████    ▀█████▄█ 
     █   ▀██▄█ ██▄      ▄██    ██      ██   █  ▄     ▀██▀ 
     █     ███ ▀██▄    ▄██▀    ██      ██     ▄██     ██▄ 
   ▄███▄    ██   ▀▀████▀▀    ▄████▄  ▄██████████▀█████▀██ 
       
   NotES!      notesss         NOTES           nOteS.

         notes..        *notes!*          notes..
   
                     Welcome to SUPERNOTES

an app for taking HEAPS of NOTES and absolutely f*cking nothing else 
                        *finger guns>>*
   ")                                                               
loop do

   puts pastel.bright_green("𝐘𝐨𝐮𝐫 𝐎𝐩𝐭𝐢𝐨𝐧𝐬:")
   puts "\n"
   puts pastel.bright_green.bold("𝐍ew 𝐍𝐨𝐭𝐞")
   puts pastel.bright_green.bold("𝐑ead 𝐏𝐫𝐞𝐯𝐢𝐨𝐮𝐬 𝐍𝐨𝐭𝐞")
   puts pastel.bright_green.bold("𝐄𝐱𝐢𝐭 𝐒𝐮𝐩𝐞𝐫 𝐍𝐨𝐭𝐞𝐬")
   puts "\n"
  
   choose = %w(Read New Delete Exit)
   choice = prompt.select("What would you like to do?", choose).to_s

   case choice
      when "New"
         puts "_________________________________________________________"
         puts pastel.green("\nGive your note a title:")
         puts "\n"
         filename = gets.chomp.to_s.gsub(" ", "_").downcase
         filename = filename + ".txt"
         puts "\n"
         puts "_________________________________________________________"
         puts pastel.green("\nNow add something to " + "#{filename}:")
         puts "\n"
         date = Date.today
         content = "\nTitle: #{filename}" + "\nDate: #{date}" + "\n\n" + gets.chomp.to_s
         create(filename, content)
         puts pastel.green("\nNote created!")
         puts "\n_________________________________________________________"
         puts  "\n"
         entries.push(filename)
         File.write("./entries.txt", entries, mode: "w")
         # entries.each do |entry|
         #    File.write("./entries.txt", entry + "\n", mode: 'w')
         #    end 
      
      when "Read"
         puts pastel.underline.green("\nNOTE LIST:")
         puts "\n"
         list = File.read("./entries.txt")
         puts list
         puts "_________________________________________________________"
         puts pastel.green("\nWhich note entry would you like to read?")
         puts pastel.green("\nType in the note's title below, and don't worry about the file extension (.txt) or the underscore!")
         puts "\n"
         filename = gets.chomp.to_s.gsub(" ", "_").downcase
         filename = filename + ".txt"
         loop do
            if File.exists?(filename) == true
               puts "_________________________________________________________"
               puts "\n"
               read(filename)
               puts "\n_________________________________________________________"
               choose2nd = %w(Done)
               choice2nd = prompt.select("Done reading?", choose2nd).to_s         
                  case choice2nd
                  when "Done"
                     puts "\n\n"
                     break                 
                  else 
                     puts pastel.red("Error!")
                  end
            else
               puts pastel.red("\nYo, that note doesn't exist...")
               break
            end  
         end

      when "Delete"
         puts pastel.underline.green("\nNOTE LIST:")
         puts "\n"
         list = File.read("./entries.txt")
         puts list
         puts "_________________________________________________________"
         puts pastel.green("\nWhich note entry would you like to delete?")
         puts "\n"
         filename = gets.chomp.to_s.gsub(" ", "_").downcase
         filename = filename + ".txt"
            if File.exists?(filename) == true
               entries.delete(filename)
               File.delete(filename)
               File.delete("./entries.txt")
               File.open("./entries.txt", "w+")
               File.write("./entries.txt", entries, mode: "w")
               
               puts pastel.red("\nNote deleted!")
               puts "\n_________________________________________________________"
            else
               puts pastel.red("Bruh, you can't delete it if it doesn't exist.")
            end
      when "Exit"
         puts "\n"
         puts pastel.bright_green("\nHave a SUPER day!")
         puts "\n"
         break
      
      else
         puts pastel.red("\nYo, that's not a valid choice. Try again...?")
      end
end