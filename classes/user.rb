class User
    attr_accessor :username, :password, :books

  # Initializes book values
  def initialize(username, password, books)
    @username = username
    @password = password
    @books = books
  end
end
