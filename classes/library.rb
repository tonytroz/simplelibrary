class Library
  attr_accessor :current_user, :users, :available_books, :checkout_limit

  # Reads database file and populate users and available books
  def initialize
    @current_user = nil
    @available_books = YAML.load(File.new("./storage/books.yml", "r"))
    @users = YAML.load(File.new("./storage/users.yml", "r"))
    @checkout_limit = 3
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
    if user.nil? || user.password != password
       return nil
    else
      @current_user = user
      return user
    end
  end

  # Checks book in to available books
  def check_in(isbn)
    found = nil
    @current_user.books.each do |b|
      if b.isbn == isbn
        found = current_user.books.index(b)
      end
    end
    if found.nil?
       return nil
    else
      @current_user.books.delete(found)
       if @available_books.include?(found)
         @available_books.index(found).availability += 1
       else
         @available_books.push(found)
       end
       return true
    end
  end

  # Checks out book to current user
  def check_out(isbn)
    # Verify user isn't at checkout limit
    if @current_user.books.length == @checkout_limit
      return "ERROR: Checkout limit reached"
    end
    # Verify user doesn't already have book
    found = nil
    @current_user.books.each do |b|
      if b.isbn == isbn
        found = current_user.books.index(b)
      end
    end
    unless found.nil?
      return "ERROR: Book already checked out."
    end
    @available_books.each do |b|
      if b.isbn == isbn
        found = @available_books.index(b)
      end
    end
    if found.nil?
      return "ERROR: Book not found"
    else
      @current_user.books.push(found)
      if @available_books.index(found).availability == 1
        @available_books.delete(found)
      else
        @available_books.index(found).availability -= 1
      end
      return "SUCCESS: Book checked out"
    end
  end

  # Lends book from current user to another user
  def lend(isbn, username)
    # Verify lend limit has not been reached
    if @current_user.books.length == @current_user.lendlimit
      puts "ERROR: Lend limit reached."
    end
    found_book = nil
    @current_user.books.each do |b|
      if b.isbn == isbn
        found_book = current_user.books.index(b)
      end
    end
    found_user = nil
    found_user = User.find_by_username(username)
    if found_book.nil? || found_user.nil? 
      return "ERROR: Book/User not found"
    else
      # Verify lendee isn't at checkout limit
      if found_user.books.length == @checkout_limit
        return "ERROR: " + username + " is at checkout limit."
      end
      @current_user.delete(found_book)
      found_user.push(found_book)
      return "SUCCESS: Book lent to " + username
    end
  end

  # Changes current user's lend limit
  def change_lend_limit(limit)
    if limit.to_i > 0
      @current_user.lendlimit = limit.to_i
    else
      nil
    end
  end
end
