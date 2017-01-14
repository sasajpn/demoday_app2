class EvalsController < ApplicationController
  def create
    @eval = current_user.evaluators.build(eval_params)
    redirect_to user_url(current_user) if @eval.save
  end

  private

  def eval_params
    params.require(:eval).permit(:level, :evaluatee_id)
  end
end
