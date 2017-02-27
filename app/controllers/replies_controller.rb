class RepliesController < ApplicationController
  def create
    @wish = Wish.find(params[:wish_id])
    @reply = @wish.replies.build(reply_params)
    if @reply.save
      redirect_to book_wish_url(@wish.book, @wish), notice: 'これがいいな！しました。'
    else
      render 'wishes/show'
    end
  end

  def destroy
  end

  private

  def reply_params
    params.require(:reply).permit(:book_id)
  end
end
