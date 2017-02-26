class WishListsController < ApplicationController
  before_action :set_wish_list, only: [:update, :destroy]

  def index
    @wish_lists = current_user.wish_lists.where.not(get: true).order(created_at: :desc)
  end

  def new
    @wish_lists = []
    retry_count = 0
    begin
      if params[:keyword].present?
        Amazon::Ecs.debug = true
        wish_lists = Amazon::Ecs.item_search(
          params[:keyword],
          search_index: 'Books',
          dataType: 'script',
          response_group: 'ItemAttributes, Images',
          country: 'jp',
          power: 'Not kindle'
        )
        wish_lists.items.each do |item|
          wish_list = current_user.wish_lists.build(
            title: item.get('ItemAttributes/Title'),
            author: item.get('ItemAttributes/Author'),
            image: item.get('LargeImage/URL')
          )
          @wish_lists << wish_list
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
    @wish_list = current_user.wish_lists.build(wish_list_params)
    if @wish_list.save
      redirect_to user_wish_lists_url(current_user), notice: 'ほしいものリストに追加しました。'
    else
      @wish_lists = []
      @wish_list.errors.full_messages.each do |error|
        flash.now[:alert] = error
      end
      render :new
    end
  end

  def update
    if @wish_list.update(update_wish_list_params)
      redirect_to user_wish_lists_url(current_user), notice: 'ほしいものリストを更新しました。'
    end
  end

  def destroy
    @wish_list.destroy
    redirect_to user_wish_lists_url(current_user), notice: 'ほしいものリストから削除しました。'
  end

  private

  def wish_list_params
    params.require(:wish_list).permit(:title, :author, :image)
  end

  def update_wish_list_params
    params.require(:wish_list).permit(:get)
  end

  def set_wish_list
    @wish_list = WishList.find(params[:id])
  end
end
