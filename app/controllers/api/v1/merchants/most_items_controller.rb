class Api::V1::Merchants::MostItemsController < ApplicationController
  def index
    most_item_merchants = Merchant.most_items_sold(params[:quantity])
    render json: MerchantSerializer.new(most_item_merchants)
  end
end

