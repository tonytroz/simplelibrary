require 'spec_helper'
require 'digest/sha1'

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
    it "has a number of lends of zero" do
      @library.num_lends.should == 0
    end
  end
 
  describe :login do
    before :each do
      @library.login("username1", "password1")
    end

    it "should should set current user" do 
      @library.current_user.username.should == "username1"
      @library.current_user.password.should == "password1"
    end

    describe :check_out do
      it "checks out valid book" do
        @library.check_out("1").should == "SUCCESS: Book checked out"
      end
      it "does not check out same book twice" do
        @library.check_out("1").should == "ERROR: Book already checked out."
      end
      it "does not check out invalid book" do
        @library.check_out("6").should == "ERROR: Book not found"
      end
      it "does not check out book when checkout limit reached" do
        @library.check_out("1")
        @library.check_out("2")
        @library.check_out("3")
        @library.check_out("4").should == "ERROR: Checkout limit reached"
      end
    end

    describe :check_in do
      it "checks in user book" do
        @library.check_in("1").should == "SUCCESS: Book checked in"
      end
      it "does not check in invalid book" do
        @library.check_in("5").should == "ERROR: Book not found"
      end
    end

    describe :change_lend_limit do
      it "returns SUCCESS if limit is valid" do
        @library.change_lend_limit(1).should == "SUCCESS: Limit changed to 1"
      end
      it "returns ERROR if limit is less than 1" do
        @library.change_lend_limit(-1).should == "ERROR: Limit invalid"
      end
      it "returns ERROR if limit is greater than 10" do
        @library.change_lend_limit(11).should == "ERROR: Limit invalid"
      end
    end

    describe :lend do
      it "does not lend invalid book" do
        @library.lend("6","username2").should == "ERROR: Book/User not found"
      end
      it "does not lend to invalid user" do
        @library.lend("3","username6").should == "ERROR: Book/User not found"
      end
      it "does not allow lends to self" do
        @library.lend("3","username1").should == "ERROR: Cannot lend to self."
      end
      it "lends valid book to valid user" do
        @library.lend("2","username2").should == "SUCCESS: Book lent to username2"
      end
      it "does not lend when lend limit reached" do
        @library.lend("3","username2").should == "ERROR: Lend limit reached"
      end
      it "does not lend when other user checkout limit reached" do
        @library.checkout_limit = 1
        @library.change_lend_limit(2)
        @library.lend("3","username2").should == "ERROR: username2 is at checkout limit"
      end
    end

     describe :save do
      it "should modify books file" do
        prev_sha1 = Digest::SHA1.hexdigest(File.read("./storage/books.yml"))
        @library.available_books.pop
        @library.save
        Digest::SHA1.hexdigest(File.read("./storage/books.yml")).should_not == prev_sha1
      end
      it "should modify users file" do
        prev_sha1 = Digest::SHA1.hexdigest(File.read("./storage/users.yml"))
        @library.users.pop
        @library.save
        Digest::SHA1.hexdigest(File.read("./storage/users.yml")).should_not == prev_sha1
      end
    end
  end
end
