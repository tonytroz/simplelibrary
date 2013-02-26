require 'spec_helper'

describe Book do
  before :each do
    @book = Book.new("isbn", "name", "author", :availability, :format, :genre, :language)
  end

  describe "#new" do
    it "initializes with seven parameters and returns a Book" do
      @book.should be_an_instance_of Book
    end
  end

  describe "isbn" do
    it "returns correct isbn" do
      @book.isbn.should == "isbn"
    end
  end
  describe "name" do
    it "returns correct name" do
      @book.name.should == "name"
    end
  end
  describe "author" do
    it "returns correct author" do
      @book.author.should == "author"
    end
  end
  describe "availability" do
    it "returns correct availability" do
      @book.availability.should == :availability
    end
  end
  describe "format" do
    it "returns correct format" do
      @book.format.should == :format
    end
  end
  describe "genre" do
    it "returns correct genre" do
      @book.genre.should == :genre
    end
  end
  describe "language" do
    it "returns correct language" do
      @book.language.should == :language
    end
  end

end
