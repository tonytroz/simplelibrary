require "./classes/book"
require "./classes/user"
require "./classes/library"

def usage
  puts "==========================================="
  puts "== Commands:                             =="
  puts "== checkin checkout lend limit quit help =="
  puts "==========================================="
end

library = Library.new
puts "=================================================="
puts "== Welcome to the Simple Library Account System =="
puts "=================================================="
usage()
user_input = nil
while(user_input != "quit")
    user_input = gets.chomp
    case user_input
    when "checkin"
      library.checkin()
    when "checkout"
      library.checkout()
    when "lend"
      library.lend()
    when "limit"
      library.limit()
    when "quit"
      library.save()
    when "help"
      usage()
    else
      puts "Invalid command."
      usage()
    end
end
