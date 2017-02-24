class ActionsController < ApplicationController
  def create
    @action = current_user.actions.build(action_params)
    redirect_to items_url, notice: 'ほしいな！をしました。' if @action.save
  end

  def destroy
    @action = Action.find(params[:id])
    @action.destroy
    redirect_to items_url, notice: 'ほしいな！を取り消しました。'
  end

  private

  def action_params
    params.permit(:book_id)
  end
end
