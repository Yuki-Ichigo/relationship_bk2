class BooksController < ApplicationController
  before_action :authenticate_user!

  def show
    @book = Book.find(params[:id])
    @book2 = Book.new
    @user = @book.user
  end

  def index
    @books = Book.all
    @book = Book.new
    @book.user_id = current_user.id
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book2 = Book.find(params[:id])
    if @book2.user != current_user
      redirect_to books_path
    end
  end


  def update
    @book2 = Book.find(params[:id])
    if @book2.update(book_params)
      redirect_to book_path(@book2), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def delete
    @book = Book.find(params[:id])
    @book.destoy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
