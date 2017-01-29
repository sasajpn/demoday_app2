class DealsController < ApplicationController
  def index
    @deals = Book.where(status: 1).where.not(user_id: current_user)
    @search = @deals.search(params[:q])
    @search_deals = @search.result(distinct: true)
  end
end
