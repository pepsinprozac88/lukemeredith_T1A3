require 'date'


$/ = "_________________________________________________________" + "\n"

def read(filename)
   puts $/
   File.open(filename).each do |text|
   puts text
   end
end

def create(filename, content)
   puts $/
   File.open(filename, "w") do |file|     
   file.write(content)
   end
end

loop do
   puts"\n\n
                        ▄▄    ▄▄                                                                         ▄▄  
   ▀███▀▀▀██▄           ██  ▀███                  ▀████▀                                               ▀███  
     ██    ▀██▄               ██                    ██                                                   ██  
     ██     ▀██▄█▀██▄ ▀███    ██ ▀██▀   ▀██▀        ██   ▄██▀██▄▀███  ▀███ ▀███▄███▀████████▄  ▄█▀██▄    ██  
     ██      ███   ██   ██    ██   ██   ▄█          ██  ██▀   ▀██ ██    ██   ██▀ ▀▀  ██    ██ ██   ██    ██  
     ██     ▄██▄█████   ██    ██    ██ ▄█           ██  ██     ██ ██    ██   ██      ██    ██  ▄█████    ██  
     ██    ▄██▀█   ██   ██    ██     ███       ███  ██  ██▄   ▄██ ██    ██   ██      ██    ██ ██   ██    ██  
   ▄████████▀ ▀████▀██▄████▄▄████▄   ▄█         █████    ▀█████▀  ▀████▀███▄████▄  ▄████  ████▄████▀██▄▄████▄
                                   ▄█                                                                        
                                 ██▀"                                                                         
   
   puts "\nWELCOME!\n\n"
   puts "What would you like to do?"
   puts "-Read- a journal entry"
   puts "-Create- a new journal entry"
   puts $/
   choice = gets.chomp.downcase
   case choice
   when "read"
      puts $/
      puts "Which note would you like to open?"
      puts "\n"
      filename = gets.chomp.to_s.gsub(" ", "_")
      filename = "./" + filename + ".txt"
      read(filename)
      puts $/
   when "create"
      puts "Give your note a title:"
      puts "\n"
      filename = gets.chomp.to_s.gsub(" ", "_")
      filename = filename + ".txt"
      puts "\n"
      puts $/
      puts "Now add something to " + "#{filename}:"
      puts "\n"
      date = Date.today
      content = "Date: #{date}" + "\n" + "Title: #{filename}" + "\n\n" + gets.chomp.to_s
      create(filename, content)
      puts "\n"
      puts "Note created!"
   else
      puts "Dude... That's not a valid choice."
   end
end