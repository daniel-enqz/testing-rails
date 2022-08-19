class BooksController < ApplicationController
  skip_before_action :authenticate_author!, only: :index
  before_action :set_author, except: :index
  before_action :set_book, except: [:index, :new, :create]

  def show
  end

  def index
    @books = Book.all.by_alphabetic_order
  end

  def new
    @book = @author.books.new
  end

  def create
    @book = @author.books.new(book_params)
    if @book.save
      redirect_to books_path, notice: "Book successfully created"
    else
      flash.now[:alert] = "Something went wrong"
      render "new", status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @book.assign_attributes(book_params)
    if @book.save
      redirect_to books_path, notice: "Book successfully edited"
    else
      flash.now[:alert] = "Something went wrong"
      render "edit", status: :unprocessable_entity
    end
  end

  def destroy
    if @book.destroy
      flash[:success] = "Book successfully deleted"
    else
      flash[:error] = "Something went wrong"
    end
    redirect_to books_path
  end

  private

  def set_author
    @author = current_author
  end

  def set_book
    @book = current_author.books.find(params[:id])
  end

  def book_params
    params.require(:book).permit(
      :title,
      :genre
    )
  end
end
