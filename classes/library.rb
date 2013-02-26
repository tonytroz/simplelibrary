class Library
  attr_accessor :current_user, :users, :available_books, :checkout_limit, :num_lends

  # Reads database file and populate users and available books
  def initialize
    @current_user = nil
    @available_books = YAML.load(File.new("./storage/books.yml", "r"))
    @users = YAML.load(File.new("./storage/users.yml", "r"))
    @checkout_limit = 3
    @num_lends = 0
  end

  # Serializes users and available books to database file
  def save
    File.open("./storage/books.yml", "w") do |f|
      YAML.dump(@available_books,f)
      f.close
    end
    File.open("./storage/users.yml", "w") do |f|
      YAML.dump(@users,f)
      f.close
    end
  end

  # Verifies user credentials and sets current user
  def login(username, password)
    user = User.find_by_username(username)
    unless user.nil? || user.password != password
       @current_user = user
    end
  end

  # Checks book in to available books
  def check_in(isbn)
    if isbn == "cancel"
      return "Command cancelled"
    end
    found = nil
    @current_user.books.each do |b|
      if b.isbn == isbn
        found = b
      end
    end
    if found.nil?
       return "ERROR: Book not found"
    else
      @current_user.books.delete(found)
       if @available_books.include?(found)
         index = @available_books.index(found)
         @available_books[index].availability += 1
       else
         @available_books.push(found)
       end
       return "SUCCESS: Book checked in"
    end
  end

  # Checks out book to current user
  def check_out(isbn)
    if isbn == "cancel"
      return "Command cancelled"
    end
    # Verify user isn't at checkout limit
    if @current_user.books.length >= @checkout_limit
      return "ERROR: Checkout limit reached"
    end
    # Verify user doesn't already have book
    found = nil
    @current_user.books.each do |b|
      if b.isbn == isbn
        found = b
      end
    end
    unless found.nil?
      return "ERROR: Book already checked out."
    end
    @available_books.each do |b|
      if b.isbn == isbn
        found = b
      end
    end
    if found.nil?
      return "ERROR: Book not found"
    else
      @current_user.books.push(found)
      if found.availability == 1
        @available_books.delete(found)
      else
        found.availability -= 1
      end
      return "SUCCESS: Book checked out"
    end
  end

  # Lends book from current user to another user
  def lend(isbn, username)
    if isbn == "cancel" || username == "cancel"
      return "Command cancelled"
    end
    if @current_user.username == username
      return "ERROR: Cannot lend to self."
    end
    # Verify lend limit has not been reached
    if @num_lends >= @current_user.lendlimit
      return "ERROR: Lend limit reached"
    end
    found_book = nil
    @current_user.books.each do |b|
      if b.isbn == isbn
        found_book = b
      end
    end
    found_user = nil
    found_user = User.find_by_username(username)
    if found_book.nil? || found_user.nil? 
      return "ERROR: Book/User not found"
    else
      # Verify lendee isn't at checkout limit
      if found_user.books.length == @checkout_limit
        return "ERROR: " + username + " is at checkout limit"
      end
      @current_user.books.delete(found_book)
      found_user.books.push(found_book)
      @num_lends += 1
      return "SUCCESS: Book lent to #{username}"
    end
  end

  # Changes current user's lend limit
  def change_lend_limit(limit)
    if limit.to_i >= 0 && limit.to_i <= 10
      @current_user.lendlimit = limit.to_i
      return "SUCCESS: Limit changed to #{limit}"
    else
      return "ERROR: Limit invalid"
    end
  end
end
