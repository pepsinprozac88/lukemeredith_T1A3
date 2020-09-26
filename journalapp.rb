require 'date'
require 'pastel'
require 'tty-prompt'

prompt = TTY::Prompt.new(active_color: :green)
pastel = Pastel.new

entries = []

def read(filename)
   puts "_________________________________________________________"
   File.open(filename).each do |text|
   puts text
   end
end

def create(filename, content)
   puts "_________________________________________________________"
   File.open(filename, "w") do |file|     
   file.write(content)
   end
end

puts pastel.green("\n\n

                        ▄▄    ▄▄                                                                         ▄▄  
   ▀███▀▀▀██▄           ██  ▀███                  ▀████▀                                               ▀███  
     ██    ▀██▄               ██                    ██                                                   ██  
     ██     ▀██▄█▀██▄ ▀███    ██ ▀██▀   ▀██▀        ██   ▄██▀██▄▀███  ▀███ ▀███▄███▀████████▄  ▄█▀██▄    ██  
     ██      ███   ██   ██    ██   ██   ▄█          ██  ██▀   ▀██ ██    ██   ██▀ ▀▀  ██    ██ ██   ██    ██  
     ██     ▄██▄█████   ██    ██    ██ ▄█           ██  ██     ██ ██    ██   ██      ██    ██  ▄█████    ██  
     ██    ▄██▀█   ██   ██    ██     ███       ███  ██  ██▄   ▄██ ██    ██   ██      ██    ██ ██   ██    ██  
   ▄████████▀ ▀████▀██▄████▄▄████▄   ▄█         █████    ▀█████▀  ▀████▀███▄████▄  ▄████  ████▄████▀██▄▄████▄
                                   ▄█                                                                        
                                 ██▀                                                                        
                                 
                                 ")                                                               
loop do
   puts "𝐖𝐞𝐥𝐜𝐨𝐦𝐞! 𝐘𝐨𝐮𝐫 𝐎𝐩𝐭𝐢𝐨𝐧𝐬:"
   puts "\n"
   puts pastel.bright_green.bold("𝐍ew 𝐉𝐨𝐮𝐫𝐧𝐚𝐥 𝐄𝐧𝐭𝐫𝐲")
   puts pastel.bright_green.bold("𝐑ead 𝐏𝐫𝐞𝐯𝐢𝐨𝐮𝐬 𝐉𝐨𝐮𝐫𝐧𝐚𝐥 𝐄𝐧𝐭𝐫𝐲")
   puts pastel.bright_green.bold("𝐂lose 𝐃𝐚𝐢𝐥𝐲 𝐉𝐨𝐮𝐫𝐧𝐚𝐥")
   puts "\n"
   choose = %w(New Read Close)
   choice = prompt.select("What would you like to do?", choose).to_s
   case choice
   when "New"
      puts "_________________________________________________________"
      puts "\n"
      puts "Give your journal entry a title:"
      puts "\n"
      filename = gets.chomp.to_s.gsub(" ", "_").downcase
      filename = filename + ".txt"
      puts "\n"
      puts "_________________________________________________________"
      puts "\n"
      puts "Now add something to " + "#{filename}:"
      puts "\n"
      date = Date.today
      content = "Date: #{date}" + "\n" + "Title: #{filename}" + "\n\n" + gets.chomp.to_s
      create(filename, content)
      puts "\n"
      puts "Note created!"
      # entries.push(filename)
      File.open("./entries.txt", "w") do |file|
         file.write(filename)
      end
   when "Read"
      # entries.each {|entry| puts "Title: #{entry}"}
      read("./entries.txt")
      puts "_________________________________________________________"
      puts "Which journal entry would you like to read?"
      puts "\n"
      filename = gets.chomp.to_s.gsub(" ", "_").downcase
      filename = "./" + filename + ".txt"
      read(filename)
      puts "_________________________________________________________"
   when "Close"
      break
   else
      puts "Yo, that's not a valid choice."
   end
end