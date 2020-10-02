# I couldn't get this to work with the executable supernotes file. Tried for hours... Would love to know what I was doing wrong.

def help
   if ARGV.first == '-h' || ARGV.first == '--help'
      File.open("../docs/help.txt").each do |text|
         puts text
         end
       exit
   elsif ARGV.first == '-v' || ARGV.first == '-version'
       puts 'This is version beta 0.1 of SuperNotes'
       exit
   elsif ARGV.first == '-a' || ARGV.first == '-all'
       puts '
       -a              list all command line arguments
       -all            list all command line arguments
       -h              help
       -help           help
       -v              show version information
       -version        show version information
       '
       exit
   elsif ARGV.first != nil
       puts 'Invalid command line argument; please type -a for a list of all valid commands'
       exit
   end
end

