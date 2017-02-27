class WishesController < ApplicationController
  before_action :set_wish, except: [:create]

  def show
    @user = @wish.user
    @reply = @wish.replies.build
    @yet_reply = @wish.replies.where(status: 0)
  end

  def create
    @wish = current_user.wishes.build(wish_params)
    redirect_to items_url, notice: 'ほしいな！をしました。' if @wish.save
  end

  def update
    if @wish.update(update_wish_params)
      redirect_to user_books_url(current_user), notice: 'ほしいな！をお断りしました。'
    end
  end

  def destroy
    @wish.destroy
    redirect_to items_url, notice: 'ほしいな！を取り消しました。'
  end

  private

  def wish_params
    params.require(:wish).permit(:book_id)
  end

  def update_wish_params
    params.require(:wish).permit(:reject)
  end

  def set_wish
    @wish = Wish.find(params[:id])
  end
end
