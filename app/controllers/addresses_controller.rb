#require 'indirizzo/address'

class AddressesController < ApplicationController
  def index
    render 'new'
  end

  def new
    @address = Address.new
  end

  def show

  end

  def create
    @address = Address.new(address_params)
    if @address.save
      flash[:success] = "Address validated successfully!"
      redirect_to @address
    else
      render 'new'
    end
  end

  private

  def address_params
    params.require(:address).permit(:street_name, :city, :state, :zip_5)
  end
end
