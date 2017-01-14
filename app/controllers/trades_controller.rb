class TradesController < ApplicationController
  def index
    @negotiate = Negotiate.find(params[:negotiate_id])
  end
end
