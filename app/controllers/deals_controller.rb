class DealsController < ApplicationController
  def index
    @books = Book.where(status: 1).where.not(user_id: current_user)
    @search = @books.search(params[:q])
    @books = @search.result(distinct: true)
  end
end
