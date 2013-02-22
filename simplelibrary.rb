# simplelibrary
# Created by Tony Trozzo <tonytroz@gmail.com>
# 02/21/2013

require_relative "./classes/book"
require_relative "./classes/user"
require_relative "./classes/library"
require "yaml"

# Formats user reponses and prints to screen
# Text must be less than 45 characters
def print_screen(text)
  puts "=================================================="
  puts "== " + text + " " * (44-text.length) + " =="
  puts "=================================================="
end

# Prints user commmands
def usage
  puts "=================================================="
  puts "== Commands:                                    =="
  puts "=================================================="
  puts "== checkin checkout lend limit quit help        =="
  puts "=================================================="
end

# Create library instance
library = Library.new
print_screen("Welcome to the Simple Library Account System")
print_screen("Enter Username:")
username = gets.chomp
print_screen("Enter Password:")
password = gets.chomp
user = library.login(username, password)
# Check for valid user
if user.nil?
  print_screen("ERROR: Invalid login")
  exit 1
end
usage()
# Handle user commands
user_input = nil
while(user_input != "quit")
    user_input_menu = gets.chomp
    case user_input_menu
    when "checkin"
      print_screen("Choose a Book to Check In by ISBN:")
      user.books.each do |b|
        puts b.isbn
      end
      user_input_book = gets.chomp
      if library.checkin(user_input_book)
        print_screen("SUCCESS: Book checked in")
      else
        print_screen("ERROR: Book not found")
      end
    when "checkout"
      print_screen("Choose a Book to Check Out by ISBN:")
      library.available_books.each do |b|
        puts b.isbn + "|" + b.author + "|" + b.name
      end
      user_input_book = gets.chomp
      if library.checkout(user_input_book)
        print_screen("SUCCESS: Book checked out")
      else
        print_screen("ERROR: Book not found")
      end
    when "lend"
      # Verify user has not hit lend limit.
      print_screen("Choose a Book to Lend by ISBN:")
      user.books.each do |b|
        puts b.isbn
      end
      user_input_book = gets.chomp
      print_screen("Choose a Book to Lend by Username:")
      library.users.each do |u|
        puts u.username
      end
      user_input_user = gets.chomp
      if library.lend(user_input_user, user_input_book)
        print_screen("SUCCESS: Book lent to user")
      else
        print_screen("ERROR: Book/User not found")
      end
    when "limit"
      print_screen("Choose a Book to Lend by Username:")
      user_input_limit = gets.chomp
      if library.limit(user_input_limit)
        print_screen("SUCCESS: Limit changed")
      else
        print_screen("ERROR: Limit invalid")
      end
    when "quit"
      print_screen("Saving and exiting application")
      library.save()
      exit 0
    when "help"
      usage()
    else      
      print_screen("ERROR: Command invalid")
      usage()
    end
end
