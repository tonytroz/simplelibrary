class User
  attr_accessor :username, :password, :lendlimit, :books

  # Initializes user values
  def initialize(username, password, lendlimit)
    @username = username
    @password = password
    @lendlimit = lendlimit
    @books = []
  end
  
  # Find user by username
  def self.find_by_username(username)
    user = nil
    ObjectSpace.each_object(User) do |u|
      user = u if u.username == username
    end
    user
  end
end
