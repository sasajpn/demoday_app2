class TradesController < BooksController
  before_action :set_object

  def show
  end

  private

  def set_object
    @negotiate = Negotiate.find(params[:negotiate_id])
    @parent = @negotiate.parent
    @child = @negotiate.child
    @object = current_user == @parent.user ? @parent : @child
    @other = current_user == @parent.user ? @child : @parent
  end
end
