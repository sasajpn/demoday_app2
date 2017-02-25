class WishListsController < ApplicationController

  def index
    @wish_list = current_user.wish_lists.order(created_at: :desc)
  end
end
