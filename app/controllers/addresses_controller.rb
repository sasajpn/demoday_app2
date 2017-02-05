class AddressesController < ApplicationController
  before_action :set_address, except: [:new, :create]
  before_action :set_request_from, only: [:new, :edit]
  skip_before_action :user_book_check

  def new
    @address = current_user.build_address
  end

  def create
    @address = current_user.build_address(address_params)
    if @address.save
      if session[:request_from]
        redirect_to session[:request_from], notice: 'お届け先を登録しました。'
      else
        redirect_to edit_user_url(current_user), notice: 'お届け先を登録しました。'
      end
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @address.update(address_params)
      if session[:request_from]
        redirect_to session[:request_from], notice: 'お届け先を変更しました。'
      else
        redirect_to edit_user_url(current_user), notice: 'お届け先を変更しました。'
      end
    else
      render :edit
    end
  end

  private

  def address_params
    params.require(:address).permit(
      :user_id,
      :given_name, :family_name,
      :postal_code, :prefecture, :municipality, :street, :building)
  end

  def set_address
    @address = Address.find(params[:id])
  end

  def set_request_from
    session[:request_from] = request.referer
  end
end
