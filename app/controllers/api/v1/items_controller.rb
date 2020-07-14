class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show
    render json: ItemSerializer.new(Item.find(params[:id]))
  end

  def create
    new_item = Item.create(item_params)
    if new_item.save
      render json: ItemSerializer.new(new_item)
    end
  end

  def destroy
    render json: ItemSerializer.new(Item.destroy(params[:id]))
  end

  private
  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id)
  end
end
