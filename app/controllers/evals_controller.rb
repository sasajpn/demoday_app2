class EvalsController < ApplicationController
  before_action :set_book

  def create
    @eval = current_user.evaluators.build(eval_params)
    if @eval.save
      @book.update(book_params)
      redirect_to user_books_url(current_user), notice: '取引相手を評価しました。'
    end
  end

  private

  def eval_params
    params.require(:eval).permit(:level, :evaluatee_id)
  end

  def book_params
    params.require(:book).permit(:status)
  end

  def set_book
    @book = Book.find(params[:book_id])
  end
end
