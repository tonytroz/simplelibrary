class Library
  attr_accessor :current_user, :users, :available_books

  # Reads database file and populate users and available books
  def initialize
    @available_books = []
  end

  # Serializes users and available books to database file
  def save
  end

  # Verifies user credentials and sets current user
  def login(username, password)
    @current_user = username
  end

  # Checks book in to current user
  def check_in(book)
  end

  # Checks out book to current user
  def check_out(book)
  end

  # Lends book from current user to another user
  def lend(book, user)
  end

  # Changes current user's lend limit
  def change_lend_limit(limit)
  end
end
