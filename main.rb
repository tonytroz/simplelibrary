# simplelibrary
# Created by Tony Trozzo <tonytroz@gmail.com>
# 02/21/2013

require "./classes/book"
require "./classes/user"
require "./classes/library"

# Print user commmands
def usage
  puts "=================================================="
  puts "== Commands:                                    =="
  puts "=================================================="
  puts "== checkin checkout lend limit quit help        =="
  puts "=================================================="
end

# Create library instance
library = Library.new
puts "=================================================="
puts "== Welcome to the Simple Library Account System =="
puts "=================================================="
puts "== Enter Username:                              =="
puts "=================================================="
username = gets.chomp
puts "=================================================="
puts "== Enter Password:                              =="
puts "=================================================="
password = gets.chomp
user = library.login(username, password)
# Check for valid user
if user.nil?
  puts "=================================================="
  puts "== ERROR: Invalid login                         =="
  puts "=================================================="
  exit 1
end
usage()
# Handle user commands
user_input = nil
while(user_input != "quit")
    user_input_menu = gets.chomp
    case user_input_menu
    when "checkin"
      puts "================================================="
      puts "== Choose a Book to Check In by ISBN:          =="
      puts "================================================="
      user.books.each do |b|
        puts b.isbn
      end
      user_input_book = gets.chomp
      if library.checkin(user_input_book)
        puts "=================================================="
        puts "== SUCCESS: Book checked in                     =="
        puts "=================================================="
      else
        puts "=================================================="
        puts "== ERROR: Book not found                        =="
        puts "=================================================="
      end
    when "checkout"
      puts "================================================="
      puts "== Choose a Book to Check Out by ISBN:         =="
      puts "================================================="
      library.available_books.each do |b|
        puts b.isbn + "|" b.author + "|" b.name
      end
      user_input_book = gets.chomp
      if library.checkout(user_input_book)
        puts "=================================================="
        puts "== SUCCESS: Book checked out                    =="
        puts "=================================================="
      else
        puts "=================================================="
        puts "== ERROR: Book not found                        =="
        puts "=================================================="
      end
    when "lend"
      # Verify user has not hit lend limit.
      puts "================================================="
      puts "== Choose a Book to Lend by ISBN:              =="
      puts "================================================="
      user.books.each do |b|
        puts b.isbn
      end
      user_input_book = gets.chomp
      puts "================================================="
      puts "== Choose a Book to Lend by Username:          =="
      puts "================================================="
      library.users.each do |u|
        puts u.username
      end
      user_input_user = gets.chomp
      if library.lend(user_input_user, user_input_book)
      if library.checkout(user_input_book)
        puts "=================================================="
        puts "== SUCCESS: Book lent to user                   =="
        puts "=================================================="
      else
        puts "=================================================="
        puts "== ERROR: Book/User not found                   =="
        puts "=================================================="
      end
    when "limit"
      puts "================================================="
      puts "== Choose a Book to Lend by Username:          =="
      puts "================================================="
      user_input_limit = gets.chomp
      if library.limit(user_input_limit)
        puts "=================================================="
        puts "== SUCCESS: Limit changed                       =="
        puts "=================================================="
      else
        puts "=================================================="
        puts "== ERROR: Limit invalid                         =="
        puts "=================================================="
      end
    when "quit"
      puts "================================================="
      puts "== Saving and exiting application.             =="
      puts "================================================="
      library.save()
      exit 0
    when "help"
      usage()
    else
        puts "=================================================="
        puts "== ERROR: Limit command                         =="
        puts "=================================================="
        usage()
    end
end
