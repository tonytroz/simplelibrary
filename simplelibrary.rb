# SimpleLibrary
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

# Prints user commmands to screen
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
# User login
print_screen("Enter Username:")
username = gets.chomp
print_screen("Enter Password:")
password = gets.chomp
library.login(username, password)
# Check for valid user
if library.current_user.nil?
  print_screen("ERROR: Invalid login")
  exit 1
end
usage
# Handle user commands
user_input = nil
while(user_input != "quit")
    user_input = gets.chomp
    case user_input
    # Allows user to check in books
    when "checkin"
      print_screen("Choose a Book to Check In by ISBN:")
      library.current_user.books.each do |b|
        puts b.isbn + "|" + b.author + "|" + b.name
      end
      user_input_book = gets.chomp
      print_screen(library.check_in(user_input_book))
    # Allows user to check out books
    when "checkout"
      print_screen("Choose a Book to Check Out by ISBN:")
      library.available_books.each do |b|
        puts b.isbn + "|" + b.author + "|" + b.name
      end
      user_input_book = gets.chomp
      print_screen(library.check_out(user_input_book))
    # Allows user to lend a book to another user
    when "lend"
      print_screen("Choose a Book to Lend by ISBN:")
      library.current_user.books.each do |b|
        puts b.isbn + "|" + b.author + "|" + b.name
      end
      user_input_book = gets.chomp
      print_screen("Choose a Book to Lend by Username:")
      library.users.each do |u|
        puts u.username
      end
      user_input_user = gets.chomp
      print_screen(library.lend(user_input_user, user_input_book))
    # Allows user to change max number of lends
    when "limit"
      print_screen("Choose a limit for number of lends (Max 10):")
      user_input_limit = gets.chomp
      print_screen(library.change_lend_limit(user_input_limit))
    # Saves and exits application
    when "quit"
      print_screen("Saving and exiting application")
      library.save
      exit 0
    # Prints usage
    when "help"
      usage
    else      
      print_screen("ERROR: Command invalid")
      usage
    end
end
