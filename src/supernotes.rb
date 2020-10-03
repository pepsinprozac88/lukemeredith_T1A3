
require_relative './methods.rb'
require_relative './title.rb'
require_relative './help.rb'
require 'date'
require 'pastel'
require 'tty-prompt'
require 'colorize'

prompt = TTY::Prompt.new(active_color: :yellow)
pastel = Pastel.new

help()

begin # opening for rescue error messasge (Although, there are NO errors.)

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
            puts pastel.yellow("\nNow add something to " + pastel.white.underline("#{filename}:"))
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
               puts pastel.red.bold("\nHey man, so, that note doesn't actually exist...")
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
               puts pastel.red.bold("\nBruh, you can't delete it if it doesn't exist...")
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
         puts pastel.red.bold("\nError! You broke me! Ahhhh! How did you break me? AHHHHHHHHHHHHH!")
      end
   end

rescue 
   puts "\nError! You broke me! Ahhhh! How did you break me? AHHHHHHHHHHHHH!\n\nTry restarting the program.\nIf that fails, you may have to uninstall/reinstall Supernotes using the Help document.\nYou can find the Help Document in the SuperNotes '/docs' directory on your computer, or by typing 'ruby supernotes.rb -h' in the command line of your terminal window while inside the SuperNotes '/src' directory.".red
   puts "\n"
end

