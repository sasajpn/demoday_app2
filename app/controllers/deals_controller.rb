class DealsController < ApplicationController
  def index
    # @deals = Book.where(status: 1).where.not(user_id: current_user)
    @search = Book.ransack(params[:q])
    @deals = @search.result
  end
end
