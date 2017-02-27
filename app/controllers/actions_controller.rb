class ActionsController < ApplicationController
  before_action :set_action, except: [:create]

  def show
    @user = @action.user
    @reply = @action.replies.build
    @yet_reply = @action.replies.where(status: 0)
  end
  
  def create
    @action = current_user.actions.build(action_params)
    redirect_to items_url, notice: 'ほしいな！をしました。' if @action.save
  end

  def destroy
    @action.destroy
    redirect_to items_url, notice: 'ほしいな！を取り消しました。'
  end

  private

  def action_params
    params.permit(:book_id)
  end

  def set_action
    @action = Action.find(params[:id])
  end
end
