class Book
  attr_accessor :isbn, :name, :author, :availability, :format, :genre, :language

  # Initializes book values
  def initialize(isbn, name, author, availability, format, genre, language)
    @isbn = isbn
    @name = name
    @author = author
    @availability = availability
    @format = format
    @genre = genre
    @language = language
  end
end
