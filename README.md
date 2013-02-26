# SimpleLibrary

A simple library account system.

# Features
- Check-out and check-in books from library.
- Books have attributes (availability, format, genre, language).
- User cannot borrow more than 3 books at a time and cannot borrow the same book multiple times.
- User has ability to lend books to other users.
- User can set limit on book lending.

# Usage
    ruby simplelibrary.rb

User commands:
    checkin checkout lend limit quit help cancel

# Configuration
To reset database to default:
    ruby reset_data.rb
    