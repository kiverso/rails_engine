class Api::V1::MerchantsController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    if params[:item_id]
      item = Item.find(params[:item_id])
      merchant = item.merchant
    else
      merchant = Merchant.find(params[:id])
    end
    render json: MerchantSerializer.new(merchant)
  end

  def create
    new_merchant = Merchant.create!(merchant_params)
    render json: MerchantSerializer.new(new_merchant)
  end

  def destroy
    render json: MerchantSerializer.new(Merchant.destroy(params[:id]))
  end

  def update
    merchant = Merchant.find(params[:id])
    merchant.update(merchant_params)
    if merchant.valid?
      merchant.save
      render json: MerchantSerializer.new(merchant)
    end
  end

  private
  def merchant_params
    params.permit(:name)
  end
end
