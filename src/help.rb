ARGV.each do |arg|
   if arg == "-h" || arg == "--help"
       File.open("../docs/help.txt").each do |text|
         puts text
       end
   else
      puts "Maybe try that again, champ?"
   end
end

# I couldn't get this to work with the executable supernotes file. Tried for hours... Would love to know what I was doing wrong.