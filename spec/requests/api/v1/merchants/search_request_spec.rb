require 'rails_helper'

RSpec.describe "Api::V1::Merchants::Searches", type: :request do
  before(:each) do
    @merchant1 = Merchant.create({name: "Cool Merchant"})
    @merchant2 = Merchant.create({name: "Neat Merchant"})
    @merchant3 = Merchant.create({name: "Cooler Merchant"})
    @item1 = Item.create({name: 'Coffee Maker',
                         description: 'Put hot water in it',
                         unit_price: 12.33,
                         merchant_id: @merchant1.id})

    @item2 = Item.create({name: 'Coffee cup',
                         description: 'keeps coffee hot, hands cold',
                         unit_price: 12.45,
                         merchant_id: @merchant2.id})

    @item3 = Item.create({name: 'Coffee',
                         description: 'Tastes good',
                         unit_price: 13.33,
                         merchant_id: @merchant3.id})
  end

  describe "GET /index" do
    it "can get merchant based on find request" do
      get "/api/v1/merchants/find?name=cool&created_at=#{@merchant1.created_at}"
      expect(response).to have_http_status(:success)
      merchant = JSON.parse(response.body)
      expect(merchant['data']['attributes']['name']).to eq('Cool Merchant')
    end
  end

end
