class NegotiatesController < ApplicationController
  before_action :set_book, except: [:create]
  before_action :set_books, only: [:new]

  def index
    @negotiates = @book.children
  end

  def new
    @negotiate = Negotiate.new
  end

  def create
    @negotiate = Negotiate.new(negotiate_params)
    if @negotiate.save
      redirect_to deals_url
    else
      render :new
    end
  end

  private

  def negotiate_params
    params.require(:negotiate).permit(:parent_id, :child_id, :recommend)
  end

  def set_book
    @book = Book.find(params[:book_id])
  end

  def set_books
    @books = current_user.books.where(status: 0)
  end
end
