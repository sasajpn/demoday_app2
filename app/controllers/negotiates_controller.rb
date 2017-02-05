class NegotiatesController < ApplicationController
  before_action :set_negotiate, only: [:update, :destroy]
  before_action :set_book, only: [:show, :new, :create]
  before_action :set_books, only: [:new, :create]
  before_action :user_negotiate_check, only: [:update, :destroy]
  skip_before_action :user_check, except: [:index]
  skip_before_action :user_book_check, except: [:show]

  def index
    @negotiates = Book.where(id: Negotiate.where(child_id: current_user.books).select(:parent_id))
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
      redirect_to deals_url, notice: '本を交渉に出しました。'
    else
      render :new
    end
  end

  def update
    if @negotiate.update(update_negotiate_params)
      redirect_to book_negotiate_url(@negotiate.parent)
    end
  end

  def destroy
    @negotiate.destroy
    redirect_to user_negotiates_url(current_user), notice: '交渉を取り消しました。'
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

  def user_negotiate_check
    @negotiate = Negotiate.find_by(id: params[:negotiate_id]) || Negotiate.find_by(id: params[:id])
    @parent = @negotiate.parent
    @child = @negotiate.child
    @object = current_user == @parent.user ? @parent : @child
    unless current_user == @object.user
      redirect_to user_url(current_user), notice: "そのページはご利用いだだけません"
    end
  end
end
