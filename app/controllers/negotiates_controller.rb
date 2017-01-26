class NegotiatesController < ApplicationController
  before_action :set_negotiate, only: [:update, :destroy]
  before_action :set_book, only: [:show, :new]
  before_action :set_books, only: [:new]

  def index
    @negotiates = current_user.books.where(status: 2).order(created_at: :desc)
  end

  def show
    @negotiates = @book.parents
    @agree = @negotiates.find_by(agree: true)
  end

  def new
    @negotiate = Negotiate.new
  end

  def create
    @negotiate = Negotiate.new(negotiate_params)
    if @negotiate.save
      redirect_to books_url, notice: '本を交渉に出しました。'
    else
      redirect_to books_url, alert: '交渉に出すことができませんでした。'
    end
  end

  def update
    if @negotiate.update(update_negotiate_params)
      redirect_to book_negotiates_url(@negotiate.parent)
    end
  end

  def destroy
    @negotiate.destroy
    redirect_to user_url(current_user)
  end

  private

  def negotiate_params
    params.require(:negotiate).permit(:parent_id, :child_id, :recommend)
  end

  def update_negotiate_params
    params.require(:negotiate).permit(:agree)
  end

  def set_negotiate
    @negotiate = Negotiate.find(params[:id])
  end

  def set_book
    @book = Book.find(params[:book_id])
  end

  def set_books
    @books = current_user.books.where(status: 0)
  end
end
