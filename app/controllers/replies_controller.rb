class RepliesController < ApplicationController
  def create
    @wish = Wish.find(params[:wish_id])
    @reply = @wish.replies.build(reply_params)
    if @wish.can_reply?
      @reply.save
      redirect_to book_wish_url(@wish.book, @wish), notice: 'これがいいな！しました。'
    end
  end

  def update
    @reply = Reply.find(params[:id])
    if @reply.update(update_reply_params)
      if @reply.status == 1
        redirect_to items_url, notice: 'やめて！を選択しました。'
      else
        redirect_to items_url, notice: 'いいよ！を選択しました。'
      end
    end
  end

  def destroy
  end

  private

  def reply_params
    params.require(:reply).permit(:book_id)
  end

  def update_reply_params
    params.require(:reply).permit(:status)
  end
end
