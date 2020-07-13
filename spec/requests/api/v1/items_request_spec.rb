require 'rails_helper'

RSpec.describe "Api::V1::Items", type: :request do
  before(:each) do
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)
    @item1 = create(:item)
    @item2 = create(:item)
    @item3 = create(:item)
  end
  describe "GET /index" do
    it "returns http success" do
      get "/api/v1/items"
      expect(response).to have_http_status(:success)
    end

    it 'returns all items' do
      get "/api/v1/items"
      expect(response).to have_http_status(:success)

      items = JSON.parse(response.body)
      expect(items['data'].count).to eq(3)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/api/v1/items/#{@item1.id}"
      expect(response).to have_http_status(:success)
    end

    it "returns the item" do
      get "/api/v1/items/#{@item1.id}"

      item = JSON.parse(response.body)
      
      expect(item['data']['attributes']['id']).to eq(@item1.id)
      expect(item['data']['attributes']['name']).to eq(@item1.name)
      expect(item['data']['attributes']['description']).to eq(@item1.description)
      expect(item['data']['attributes']['unit_price']).to eq(@item1.unit_price)
      expect(item['data']['attributes']['merchant_id']).to eq(@item1.merchant_id)
    end
  end
end



