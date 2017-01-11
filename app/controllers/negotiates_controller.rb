class NegotiatesController < ApplicationController
  before_action :set_book

  def index
    @negotiates = @book.children
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end
end
