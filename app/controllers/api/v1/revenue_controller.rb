class Api::V1::RevenueController < ApplicationController
  def index
    revenue = Invoice.revenue_between(params[:start], params[:end])
    render json: RevenueSerializer.new(Revenue.new(revenue))
  end
end