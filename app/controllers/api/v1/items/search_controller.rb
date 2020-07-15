class Api::V1::Items::SearchController < ApplicationController
  def index
    @items = Item.where(nil)
    @items = @items.search_by_name(params[:name]) if params[:name]
    @items = @items.search_by_description(params[:description]) if params[:description]
    @items = @items.search_by_unit_price(params[:unit_price]) if params[:unit_price]
    @items = @items.search_by_merchant_id(params[:merchant_id]) if params[:merchant_id]
    @items = @items.search_by_created_at(params[:created_at]) if params[:created_at]
    @items = @items.search_by_updated_at(params[:updated_at]) if params[:updated_at]
    render json: ItemSerializer.new(@items)
  end

  def show
    @items = Item.where(nil)
    @items = @items.search_by_name(params[:name]) if params[:name]
    @items = @items.search_by_description(params[:description]) if params[:description]
    @items = @items.search_by_unit_price(params[:unit_price]) if params[:unit_price]
    @items = @items.search_by_merchant_id(params[:merchant_id]) if params[:merchant_id]
    @items = @items.search_by_created_at(params[:created_at]) if params[:created_at]
    @items = @items.search_by_updated_at(params[:updated_at]) if params[:updated_at]
    render json: ItemSerializer.new(@items.first)
  end
end
