class Api::V1::Merchants::HighestRevenueController < ApplicationController
  def index
    merchant = Merchant.select("merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue")
      .joins(invoices: [:invoice_items, :transactions]).group(:id)
      .where(transactions: {result: "success"})
      .group(:id)
      .order('revenue DESC')
      .limit(1)
   
    render json: MerchantSerializer.new(merchant)
  end
end
