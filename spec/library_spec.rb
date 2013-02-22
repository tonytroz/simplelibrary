require 'spec_helper'

describe Library do
  before :all do
    books = [
      Book.new("1", "A Tale of Two Cities", "Charles Dickens", 1, "Hardback", "Historical", "English"),
      Book.new("2", "The Lord of the Rings", "J.R.R. Tolkien", 2, "PDF", "Fantasy", "Spanish"),
      Book.new("3", "The Catcher In the Rye", "J.D. Salinger", 3, "EPUB", "Fiction", "Italian"),
      Book.new("4", "Charlotte's Web", "E.B. White", 4, "Paperback", "Childrens", "German"),
      Book.new("5", "The Da Vinci Code", "Dan Brown", 5, "Kindle", "Mystery", "Russian")
    ]
    users = [
      User.new("username1", "password1", 1),
      User.new("username2", "password2", 2),
      User.new("username3", "password3", 3),
      User.new("username4", "password4", 4),
      User.new("username5", "password5", 5)
    ]
    File.open("./storage/books.yml", "w") do |f|
      YAML.dump(books,f)
      f.close
    end
    File.open("./storage/users.yml", "w") do |f|
      YAML.dump(users,f)
      f.close
    end
  end
  before :each do
    @library = Library.new
  end

  describe "#new" do
    it "initializes and returns a Library" do
      @library.should be_an_instance_of Library
    end
    it "has a nil current user" do
      @library.current_user.should be_nil
    end
    it "has a checkout limit of 3" do
      @library.checkout_limit.should == 3
    end
  end
end
