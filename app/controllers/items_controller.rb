class ItemsController < ApplicationController
  skip_before_action :user_check, :user_book_check

  def index
    @items = Book.where(status: 0).where.not(user_id: current_user)
    @search = @items.search(params[:q])
    @search_items = @search.result(distinct: true)
    @action = current_user.actions.build
  end
end
