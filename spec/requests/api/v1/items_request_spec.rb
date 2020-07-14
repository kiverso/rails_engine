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
      expect(item['data']['attributes']['unit_price']).to eq(@item1.unit_price.to_f)
      expect(item['data']['attributes']['merchant_id']).to eq(@item1.merchant_id)
    end
  end

  describe 'POST /create' do
    it 'returns http success' do
      item_params = {name: "Great Coffee Product",
                     description: "It tastes good",
                     unit_price: 17.45,
                     merchant_id: @merchant1.id
                     }
      post "/api/v1/items", params: item_params
      expect(response).to have_http_status(:success)
    end

    it 'returns the new item' do
      item_params = {name: "Great Coffee Product",
                     description: "It tastes good",
                     unit_price: 17.45,
                     merchant_id: @merchant1.id
                     }
      post "/api/v1/items", params: item_params
      expect(response).to have_http_status(:success)

      item = JSON.parse(response.body)
      
      expect(item['data']['attributes']['name']).to eq('Great Coffee Product')
      expect(item['data']['attributes']['description']).to eq("It tastes good")
      expect(item['data']['attributes']['unit_price']).to eq(17.45)
      expect(item['data']['attributes']['merchant_id']).to eq(@merchant1.id)

      new_item = Item.last

      expect(new_item.name).to eq('Great Coffee Product')
      expect(new_item.description).to eq("It tastes good")
      expect(new_item.unit_price).to eq(17.45)
      expect(new_item.merchant_id).to eq(@merchant1.id)
    end
  end
end



