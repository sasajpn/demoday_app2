class DealsController < ApplicationController
  def index
    @deals = Book.where(status: 1)
  end
end
