require 'date'
require 'colorize'
require 'tty-prompt'

prompt = TTY::Prompt.new(active_color: :cyan)

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

   puts "\n\n    
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
   "                                                                   
loop do
   # puts "What would you like to do?"
   puts "\n"
   puts "-New- journal entry"
   puts "-Read- previous journal entry"
   puts "-Exit- to close the program"
   # puts "_________________________________________________________"
   puts "\n"
   choose = %w(New Read Exit)
   choice = prompt.select("What would you like to do?", choose).to_s
   case choice
   when "Read"
      puts "_________________________________________________________"
      puts "Which note would you like to open?"
      puts "\n"
      filename = gets.chomp.to_s.gsub(" ", "_").downcase
      input
      filename = "./" + filename + ".txt"
      read(filename)
      puts "_________________________________________________________"
   when "New"
      puts "_________________________________________________________"
      puts "\n"
      puts "Give your note a title:"
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
   when "Exit"
      break
   else
      puts "Yo, that's not a valid choice."
   end
end