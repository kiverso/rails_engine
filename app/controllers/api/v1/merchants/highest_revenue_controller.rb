# frozen_string_literal: true

class Api::V1::Merchants::HighestRevenueController < ApplicationController
  def index
    highest_revenue_merchants = Merchant.highest_revenue(params[:quantity])
    render json: MerchantSerializer.new(highest_revenue_merchants)
  end
end
