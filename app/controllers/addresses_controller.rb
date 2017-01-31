class AddressesController < ApplicationController
  before_action :set_address, except: [:new, :create]

  def new
    @address = current_user.build_address
    session[:request_from] = request.referer
  end

  def create
    @address = current_user.build_address(address_params)
    if @address.save
      if session[:request_from]
        redirect_to session[:request_from], notice: '住所を登録しました。'
      else
        redirect_to edit_user_url(current_user), notice: '住所を登録しました。'
      end
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @address.update(address_params)
      redirect_to edit_user_url(current_user), notice: '住所を変更しました。'
    end
  end

  def destroy
    @address.destroy
    redirect_to edit_user_url(current_user), notice: '住所を削除しました。'
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
end
