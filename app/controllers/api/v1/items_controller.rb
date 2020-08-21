# frozen_string_literal: true

class Api::V1::ItemsController < ApplicationController
  def index
    if params[:merchant_id]
      merchant = Merchant.find(params[:merchant_id])
      @items = merchant.items
    else
      @items = Item.all
    end
    render json: ItemSerializer.new(@items)
  end

  def show
    render json: ItemSerializer.new(Item.find(params[:id]))
  end

  def create
    new_item = Item.create(item_params)
    render json: ItemSerializer.new(new_item) if new_item.save
  end

  def destroy
    render json: ItemSerializer.new(Item.destroy(params[:id]))
  end

  def update
    item = Item.find(params[:id])
    item.update(item_params)
    if item.valid?
      item.save
      render json: ItemSerializer.new(item)
    end
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id)
  end
end
