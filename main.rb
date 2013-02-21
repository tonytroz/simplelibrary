# simplelibrary
# Created by Tony Trozzo <tonytroz@gmail.com>
# 02/21/2013

require "./classes/book"
require "./classes/user"
require "./classes/library"

# Print user commmands
def usage
  puts "==========================================="
  puts "== Commands:                             =="
  puts "== checkin checkout lend limit quit help =="
  puts "==========================================="
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
  puts "ERROR: Invalid Login."
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
        puts "SUCCESS: Book checked in."
      else
        puts "ERROR: Book not found."
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
        puts "SUCCESS: Book checked out."
      else
        puts "ERROR: Book not found."
      end
    when "lend"
      puts "================================================="
      puts "== Choose a Book to Lend by ISBN:              =="
      puts "================================================="
      user.books.each do |b|
        puts b.isbn
      end
      user_input_book = gets.chomp
      library.lend()
    when "limit"
      library.limit()
    when "quit"
      library.save()
      exit 0
    when "help"
      usage()
    else
      puts "ERROR: Invalid command."
      usage()
    end
end
