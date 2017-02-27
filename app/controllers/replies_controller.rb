class RepliesController < ApplicationController
  def create
    @action = Action.find(params[:action_id])
    @reply = @action.replies.build(reply_params)
    if @reply.save
      redirect_to book_action_url(@action.book, @action), notice: 'これがいいな！しました。'
    else
      render 'actions/show'
    end
  end

  def destroy
  end

  private

  def reply_params
    params.require(:reply).permit(:book_id)
  end
end
