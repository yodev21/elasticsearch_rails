class BooksController < ApplicationController
  before_action :authenticate_user!
  def index
    # @books = Book.all
    @books = Book.search({})
  end

  def show
  end

  def new
    @book = Book.new
  end

  def create
    book = current_user.books.build(book_params)
    if book.save
      redirect_to books_path
    else
      render :new
    end
  end

  def edit
  end

  private
  def book_params
    params.require(:book).permit(:title, :content)
  end
end
