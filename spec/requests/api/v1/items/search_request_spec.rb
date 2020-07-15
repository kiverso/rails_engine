require 'rails_helper'

RSpec.describe "Api::V1::Items::Searches", type: :request do
  before(:each) do
    @merchant1 = Merchant.create({name: "Cool Merchant",
                                  created_at: 'Sat, 21 Dec 2019 01:30:11 UTC +00:00',
                                  updated_at: 'Sun, 22 Dec 2019 01:30:11 UTC +00:00'})
    @merchant2 = Merchant.create({name: "Neat Merchant"})
    @merchant3 = Merchant.create({name: "Cooler Merchant"})

    @item1 = Item.create({name: 'Coffee Maker',
                         description: 'Put hot water in it',
                         unit_price: 12.33,
                         merchant_id: @merchant1.id,
                         created_at: 'Sat, 21 Dec 2019 01:30:11 UTC +00:00',
                         updated_at: 'Sun, 22 Dec 2019 01:30:11 UTC +00:00'})

    @item2 = Item.create({name: 'Coffee cup',
                         description: 'keeps coffee hot, hands cold',
                         unit_price: 12.45,
                         merchant_id: @merchant2.id})

    @item3 = Item.create({name: 'Coffee',
                         description: 'Tastes good',
                         unit_price: 13.33,
                         merchant_id: @merchant3.id})

    @item4 = Item.create({name: 'Other Thing',
                         description: 'Tastes good',
                         unit_price: 13.33,
                         merchant_id: @merchant3.id})

  end
  describe "GET /index" do
    it "can get items based on name" do
      get "/api/v1/items/find_all?name=coffee"
      expect(response).to have_http_status(:success)
      items = JSON.parse(response.body)
      expect(items['data'].length).to eq(3)
      expect(items['data'].first['attributes']['name']).to eq('Coffee Maker')
      expect(items['data'].last['attributes']['name']).to eq('Coffee')
    end
    it "can get items based on description" do
      get "/api/v1/items/find_all?description=hot"
      expect(response).to have_http_status(:success)
      items = JSON.parse(response.body)
      expect(items['data'].length).to eq(2)
      expect(items['data'].first['attributes']['name']).to eq('Coffee Maker')
      expect(items['data'].last['attributes']['name']).to eq('Coffee cup')
    end
    it "can get items based on unit_price" do
      get "/api/v1/items/find_all?unit_price=13"
      expect(response).to have_http_status(:success)
      items = JSON.parse(response.body)
      expect(items['data'].length).to eq(2)
      expect(items['data'].first['attributes']['name']).to eq('Coffee')
      expect(items['data'].last['attributes']['name']).to eq('Other Thing')
    end
    it "can get items based on merchant_id" do
      get "/api/v1/items/find_all?merchant_id=#{@merchant3.id}"
      expect(response).to have_http_status(:success)
      items = JSON.parse(response.body)
      expect(items['data'].length).to eq(2)
      expect(items['data'].first['attributes']['name']).to eq('Coffee')
      expect(items['data'].last['attributes']['name']).to eq('Other Thing')
    end
  end

  describe "GET /show" do
    it "returns only one item" do
      get "/api/v1/items/find?name=coffee"
      expect(response).to have_http_status(:success)
      items = JSON.parse(response.body)
      expect(items['data']['attributes']['name']).to eq('Coffee Maker')
    end
    it "can get an item based on created at" do
      get "/api/v1/items/find?created_at=dec"
      expect(response).to have_http_status(:success)
      items = JSON.parse(response.body)
      expect(items['data']['attributes']['name']).to eq('Coffee Maker')
    end
    it "can get an item based on updated at" do
      get "/api/v1/items/find?updated_at=2019"
      expect(response).to have_http_status(:success)
      items = JSON.parse(response.body)
      expect(items['data']['attributes']['name']).to eq('Coffee Maker')
    end
    it "can get an item based on multiple attributes" do
      get "/api/v1/items/find?name=coffee&description=hot&unit_price=45"
      expect(response).to have_http_status(:success)
      items = JSON.parse(response.body)
      expect(items['data']['attributes']['name']).to eq('Coffee cup')
    end
  end
end
