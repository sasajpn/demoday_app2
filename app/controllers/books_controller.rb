class BooksController < ApplicationController
  before_action :set_book, only: [:update, :destroy]
  skip_before_action :user_check, only: [:show, :update, :destroy]
  skip_before_action :user_book_check, only: [:index, :new, :create]

  def index
    @books = current_user.books.order(created_at: :desc)
    @search = @books.search(params[:q])
    @search_books = @search.result(distinct: true)
  end

  def new
    @books = []
    retry_count = 0
    begin
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
    rescue
      retry_count += 1
      retry
      sleep(5) if retry_count < 5
      flash.now[:alert] = '申し訳ございませんが、もう一度検索してください。'
    end
  end

  def create
    @book = current_user.books.build(book_params)
    if @book.save
      redirect_to user_books_url(current_user), notice: '本を登録しました。'
    else
      @books = []
      @book.errors.full_messages.each do |error|
        flash.now[:alert] = error
      end
      render :new
    end
  end

  def update
    if @book.update(update_book_params)
      redirect_to user_books_url(current_user), notice: @book.notice_message if @book.status <= 2
      redirect_to negotiate_trade_url(@book.set_negotiate), notice: @book.notice_message if @book.status >= 4
    end
  end

  def destroy
    @book.destroy
    redirect_to user_books_url(current_user), notice: '本を削除しました。'
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :image, :condition, :status)
  end

  def update_book_params
    params.require(:book).permit(
      :status,
      book_address_attributes: [:id, :given_name, :family_name,
        :postal_code, :prefecture, :municipality, :street, :building])
  end

  def set_book
    @book = Book.find_by(id: params[:book_id]) || Book.find(params[:id])
  end
end
