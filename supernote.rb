begin # opening for rescue error messasge (Although, there are NO errors.)

   

require 'date'
require 'pastel'
require 'tty-prompt'

prompt = TTY::Prompt.new(active_color: :yellow)
pastel = Pastel.new

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

def instructions(option, header)
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

def back()
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

def title # returns to (i.e. prints to the screen) the app's title page.
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

A SUPER app for taking HEAPS of NOTES and absolutely f*cking NOTHING else!

                        👉 finger guns 👉")
end


# Program runs from here onwards:

loop do

   system ('clear')
   title()          

   puts pastel.yellow.underline("\n𝐘𝐨𝐮𝐫 𝐎𝐩𝐭𝐢𝐨𝐧𝐬:_______________________________________________________")
   puts "\n"
   puts pastel.yellow("𝐑ead 𝐍𝐨𝐭𝐞 | 𝐍ew 𝐍𝐨𝐭𝐞 | 𝐃𝐞𝐥𝐞𝐭𝐞 𝐍𝐨𝐭𝐞 | 𝐀𝐩𝐩𝐞𝐧𝐝 𝐍𝐨𝐭𝐞 | 𝐄𝐱𝐢𝐭")
   puts "\n"
  
   choose = %w(𝐑ead 𝐍ew 𝐃𝐞𝐥𝐞𝐭𝐞 𝐀𝐩𝐩𝐞𝐧𝐝 𝐄𝐱𝐢𝐭)
   choice = prompt.select("What would you like to do?", choose).to_s

   case choice
      when "𝐍ew"
         system ('clear')
         puts pastel.yellow("-- New Note --")
         puts "\n"
         line()
         puts pastel.yellow("\nGive your note a title:")
         puts pastel.yellow("(NOTE: Leave blank and press 'Enter' to go back)")
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
            back()
         else 
            puts "\n"
            puts pastel.red.bold("Yeah, um, you can't use the title " + pastel.yellow.underline("#{filename}") + " because it's either in-use or invalid.")
            back()
         end
      
      when "𝐑ead"
         instructions("read", "Read")
         filename = gets.chomp.to_s.gsub(" ", "_").downcase
         filename = filename + ".txt"
            if File.exists?(filename) == true
               line()
               puts "\n"
               read(filename)
               line()
               back()
            else
               puts pastel.red.bold("Hey man, so, that note doesn't actually exist...")
               line()
               back()
            end  

      when "𝐃𝐞𝐥𝐞𝐭𝐞"
         instructions("delete", "Delete")
         filename = gets.chomp.to_s.gsub(" ", "_").downcase
         filename = filename + ".txt"
         if File.exists?(filename) == true
            puts "\n"
            choose3 = %w(Yes Cancel)
            choice3 = prompt.select("Are you sure you want to delete this note?", choose3).to_s
            case choice3
               when "Yes"
                  File.delete(filename)
                  puts pastel.red.bold("\nNote deleted!")
                  line()
                  back()
               else "No"
                  puts pastel.bright_green.bold("\nCancelled.")
                  puts "\n"
                  back()
               end
            else
               puts pastel.red.bold("Bruh, you can't delete it if it doesn't exist...")
               back()
            end

      when "𝐀𝐩𝐩𝐞𝐧𝐝"
         instructions("append", "Append")
         filename = gets.chomp.to_s.gsub(" ", "_").downcase
         filename = filename + ".txt"
         if File.exists?(filename) == true
            line()
            puts "\n"
            read(filename)
            puts pastel.yellow("Add to your note here. When finished, press 'Enter' three times.")
            puts pastel.yellow("(NOTE: Your note can be mulitined. When finished, press 'Enter' three times)")
            puts "\n"
            add_text = gets("\n\n\n").to_s
            File.write(filename, add_text, File.size(filename), mode: 'a')
            puts pastel.bright_green.bold("\nNote updated!")
            back()
         else
            puts pastel.red.bold("\nBruh, you can't append it if it doesn't exist...")
            back()
         end

      when "𝐄𝐱𝐢𝐭"
         system('clear')
         puts pastel.yellow("\nHave a SUPER day!")
         puts "\n"
         break
      
      else
         puts pastel.red.bold("\nError! You broke me! Ahhhh! How did you break me? I'm error proof! AHHHHHHHHHHHHH!")
      end
end

rescue 
   puts "Error! You broke me! Ahhhh! How did you break me? I'm error proof! AHHHHHHHHHHHHH!\nTry restarting the program.\nIf that fails, you may have to uninstall/reinstall Supernotes using the HELP document.\nYou can find this document in the Supernotes directory on your computer."
end