# Used to seed the storage before the first run

require_relative "./classes/book"
require_relative "./classes/user"
require_relative "./classes/library"
require "yaml"

books = []
books.push(Book.new("1", "A Tale of Two Cities", "Charles Dickens", 1, "Hardback", "Historical", "English"))
books.push(Book.new("2", "The Lord of the Rings", "J.R.R. Tolkien", 2, "PDF", "Fantasy", "Spanish"))
books.push(Book.new("3", "The Catcher In the Rye", "J.D. Salinger", 3, "EPUB", "Fiction", "Italian"))
books.push(Book.new("4", "Charlotte's Web", "E.B. White", 4, "Paperback", "Childrens", "German"))
books.push(Book.new("5", "The Da Vinci Code", "Dan Brown", 5, "Kindle", "Mystery", "Russian"))

users = []
users.push(User.new("username1", "password1", 1))
users.push(User.new("username2", "password2", 2))
users.push(User.new("username3", "password3", 3))
users.push(User.new("username4", "password4", 4))
users.push(User.new("username5", "password5", 5))

File.open("./storage/books.yml", "w") do |f|
  YAML.dump(books,f)
  f.close
end
File.open("./storage/users.yml", "w") do |f|
  YAML.dump(users,f)
  f.close
end
