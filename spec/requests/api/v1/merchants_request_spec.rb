require 'rails_helper'

RSpec.describe "Api::V1::Merchants", type: :request do
  before(:each) do
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)
    @merchant3 = create(:merchant)
    @merchant4 = create(:merchant)
    @item = Item.create({name: 'Item',
                         description: 'item',
                         unit_price: 12.33,
                         merchant_id: @merchant3.id})
  end
  describe "GET /index" do
    it "returns http success" do
      get "/api/v1/merchants"
      expect(response).to have_http_status(:success)
    end

    it 'returns all merchants' do
      get "/api/v1/merchants"
      expect(response).to have_http_status(:success)

      merchants = JSON.parse(response.body)
      expect(merchants['data'].count).to eq(4)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/api/v1/merchants/#{@merchant1.id}"
      expect(response).to have_http_status(:success)
    end

    it "returns the merchant" do
      get "/api/v1/merchants/#{@merchant1.id}"

      merchant = JSON.parse(response.body)
      
      expect(merchant['data']['attributes']['id']).to eq(@merchant1.id)
      expect(merchant['data']['attributes']['name']).to eq(@merchant1.name)
    end
  end

  describe 'POST /create' do
    it 'returns the merchant on successful request' do
      merchant_params = {name: 'New Merchant'}
      post "/api/v1/merchants", params: merchant_params
      expect(response).to have_http_status(:success)
      
      merchant = JSON.parse(response.body)
      
      expect(merchant['data']['attributes']['name']).to eq('New Merchant')
      expect(Merchant.last.name).to eq("New Merchant")
    end
  end

  describe 'update' do
    it 'returns the merchant on successful update' do
      merchant_params = {name: 'New Merchant'}
      patch "/api/v1/merchants/#{@merchant1.id}", params: merchant_params
      expect(response).to have_http_status(:success)
      
      merchant = JSON.parse(response.body)
      @merchant1.reload
      
      expect(merchant['data']['attributes']['name']).to eq('New Merchant')
      expect(@merchant1.name).to eq("New Merchant")
    end
  end

  describe 'DELETE /destroy' do
    it 'returns deleted merchant' do
      expect(Item.all).to eq([@item])
      delete "/api/v1/merchants/#{@merchant3.id}"
      expect(response).to have_http_status(:success)

      deleted_merchant = JSON.parse(response.body)
      expect(deleted_merchant['data']['attributes']['name']).to eq(@merchant3.name)

      expect(Merchant.all).to eq ([@merchant1, @merchant2, @merchant4])
      expect(Item.all).to be_empty
    end
  end
end




