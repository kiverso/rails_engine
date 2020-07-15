class Api::V1::Merchants::SearchController < ApplicationController
  def index
    @merchants = Merchant.where(nil)
    @merchants = @merchants.search_by_name(params[:name]) if params[:name]
    @merchants = @merchants.search_by_created_at(params[:created_at]) if params[:created_at]
    @merchants = @merchants.search_by_updated_at(params[:updated_at]) if params[:updated_at]
    render json: MerchantSerializer.new(@merchants)
  end
end
