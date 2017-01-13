class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book, only: [:update, :destroy]

  def new
    @books = []
    if params[:keyword].present?
      Amazon::Ecs.debug = true
      books = Amazon::Ecs.item_search(
        params[:keyword],
        search_index: 'Books',
        dataType: 'script',
        response_group: 'ItemAttributes, Images',
        country: 'jp',
        power: 'Not kindle'
      )
      books.items.each do |item|
        book = current_user.books.build(
          title: item.get('ItemAttributes/Title'),
          author: item.get('ItemAttributes/Author'),
          image: item.get('LargeImage/URL')
        )
        @books << book
      end
    end
  end

  def create
    @book = current_user.books.build(book_params)
    if @book.save
      redirect_to user_url(current_user)
    else
      @books = []
      render :new
    end
  end

  def update
    redirect_to user_url(current_user) if @book.update(update_book_params)
  end

  def destroy
    @book.destroy
    redirect_to user_url(current_user)
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :image, :condition)
  end

  def updare_book_params
    params.require(:book).permit(:status)
  end

  def set_book
    @book = Book.find(params[:id])
  end
end
