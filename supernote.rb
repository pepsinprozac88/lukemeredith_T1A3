require 'date'
require 'pastel'
require 'tty-prompt'
# require 'tty-reader'

# reader = TTY::Reader.new
prompt = TTY::Prompt.new(active_color: :yellow)
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

def note_list()
   pastel = Pastel.new
   puts pastel.yellow.underline("\nNote List:__________________________________________________________")
   puts "\n"
   puts Dir.glob("*.txt")
   puts "\n"
end

def line()
   pastel = Pastel.new
   puts pastel.yellow.underline"________________________________________________________________________________________"
end

def title
   pastel = Pastel.new
   puts pastel.yellow("\n\n                           SUPER                        
   ▀███▄   ▀███▀ ▄▄█▀▀██▄ ███▀▀██▀▀██████▀▀▀███ ▄█▀▀▀█▄██ 
     ███▄    █ ▄██▀    ▀██▄▀   ██   ▀█ ██    ▀█▄██    ▀██ 
     █ ███   █ ██▀      ▀██    ██      ██   █  ▀███▄   ██ 
     █  ▀██▄ █ ██        ██    ██      ██████    ▀█████▄█ 
     █   ▀██▄█ ██▄      ▄██    ██      ██   █  ▄     ▀██▀ 
     █     ███ ▀██▄    ▄██▀    ██      ██     ▄██     ██▄ 
   ▄███▄    ██   ▀▀████▀▀    ▄████▄  ▄██████████▀█████▀██ 
      
      NotES!      notesss         NOTES           nOteS.

            notes!         notes!         notes!
  
                     Welcome to SUPERNOTES

A SUPER app for taking HEAPS of NOTES and absolutely f*cking NOTHING else.

                        **finger guns**")
end

title()

loop do

   puts pastel.yellow.underline("\n𝐘𝐨𝐮𝐫 𝐎𝐩𝐭𝐢𝐨𝐧𝐬:_______________________________________________________")
   puts "\n"
   puts pastel.yellow("𝐑ead 𝐍𝐨𝐭𝐞 | 𝐍ew 𝐍𝐨𝐭𝐞 | 𝐃𝐞𝐥𝐞𝐭𝐞 𝐍𝐨𝐭𝐞 | 𝐄𝐝𝐢𝐭 𝐍𝐨𝐭𝐞 | 𝐄𝐱𝐢𝐭")
   puts "\n"
  
   choose = %w(Read New Delete Exit)
   choice = prompt.select("What would you like to do?", choose).to_s

   case choice
      when "New"
         line()
         puts pastel.yellow("\nGive your note a title:")
         puts "\n"
         filename = gets.chomp.to_s.gsub(" ", "_").downcase
         filename = filename + ".txt"
         if File.exists?(filename) == false && filename != ".txt"
            puts "\n"
            line()
            puts pastel.yellow("\nNow add something to " + pastel.underline("#{filename}:"))
            puts pastel.yellow("(NOTE: Your note can be mulitined. When finished, press 'Enter' three times)")
            puts "\n"
            date = Date.today          
            content = "Title: #{filename}" + "\nDate: #{date}" + "\n\n" + gets("\n\n\n").chomp.to_s
            create(filename, content)
            puts pastel.bright_green.bold("\nNote created!")
            puts "\n"
            choose2nd = %w(Back)
            choice2nd = prompt.select("Go Back?", choose2nd).to_s
               case choice2nd
               when "Back"
                  puts "\n"
                  title()                
               else 
                  puts pastel.red("Error!")
               end
         else 
            puts "\n"
            puts pastel.red.bold("Yeah, um, you can't use the title " + pastel.yellow.underline("#{filename}") + " because it's either in-use or invalid.")
         end
      
      when "Read"
         note_list()
         puts pastel.yellow("\nWhich note entry would you like to read?")
         puts pastel.yellow("\nType in the note's title below, and don't worry about the file extension (.txt) or the underscore!")
         puts pastel.yellow("(Leave blank and press 'Enter' to go back)")
         puts "\n"
         filename = gets.chomp.to_s.gsub(" ", "_").downcase
         filename = filename + ".txt"
         loop do
            if File.exists?(filename) == true
               line()
               puts "\n"
               read(filename)
               line()
               choose2nd = %w(Back)
               choice2nd = prompt.select("Go Back?", choose2nd).to_s         
               case choice2nd
               when "Back"
                  puts "\n"
                  title()
                  break                 
               else 
                  puts pastel.red("Error!")
               end
            else
               puts pastel.red.bold("\nYo, that note doesn't exist...")
               break
            end  
         end

      when "Delete"
         note_list()
         puts pastel.yellow("\nWhich note entry would you like to delete?")
         puts pastel.yellow("Type in the note's title below, and don't worry about the file extension (.txt) or the underscore!")
         puts "\n"
         filename = gets.chomp.to_s.gsub(" ", "_").downcase
         filename = filename + ".txt"
            if File.exists?(filename) == true
               File.delete(filename)
               puts pastel.red.bold("\nNote deleted!")
               line()
               choose2nd = %w(Back)
               choice2nd = prompt.select("Go Back?", choose2nd).to_s         
               case choice2nd
               when "Back"
                  puts "\n"
                  title()                
               else 
                  puts pastel.red("Error!")
               end
            else
               puts pastel.red.bold("\nBruh, you can't delete it if it doesn't exist...")
               puts "\n"
               choose2nd = %w(Back)
               choice2nd = prompt.select("Go Back?", choose2nd).to_s         
               case choice2nd
               when "Back"
                  puts "\n"
                  title()                
               else 
                  puts pastel.red("Error!")
               end
            end

      when "Exit"
         puts "\n"
         puts pastel.bright_green.bold("\nHave a SUPER day!")
         puts "\n"
         break
      
      else
         puts pastel.red.bold("\nYo, that's not a valid choice. Try again...?")
      end
end