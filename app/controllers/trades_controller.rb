class TradesController < ApplicationController
  before_action :user_negotiate_check
  before_action :set_object
  skip_before_action :user_check
  skip_before_action :user_book_check

  def show
  end

  private

  def set_object
    @negotiate = Negotiate.find_by(params[:negotiate_id])
    @parent = @negotiate.parent
    @child = @negotiate.child
    @object = current_user == @parent.user ? @parent : @child
    @other = current_user == @parent.user ? @child : @parent
  end

  def user_negotiate_check
    @negotiate = Negotiate.find_by(id: params[:negotiate_id]) || Negotiate.find_by(id: params[:id])
    if @negotiate.nil?
      redirect_to user_url(current_user), notice: "そのページはご利用いだだけません"
    else
      @parent = @negotiate.parent
      @child = @negotiate.child
      @object = current_user == @parent.user ? @parent : @child
      unless current_user == @object.user
        redirect_to user_url(current_user), notice: "そのページはご利用いだだけません"
      end
    end
  end
end
