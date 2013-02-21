class Library
  attr_accessor :current_user, :users, :available_books

  def init
    
  end

  def save
    
  end

  def login(username, password)
    @current_user = username
  end

  def check_in(book)
    
  end

  def check_out(book)
    
  end

  def lend(book, user)
    
  end

  def change_lend_limit(limit)
    
  end
end
