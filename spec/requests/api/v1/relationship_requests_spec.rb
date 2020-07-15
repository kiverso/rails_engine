require 'rails_helper'

RSpec.describe "Api::V1 relationships", type: :request do
  before(:each) do
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)
    @item1 = Item.create({name: "Great Coffee Product",
                          description: "It tastes good",
                          unit_price: 17.45,
                          merchant_id: @merchant1.id
                          })
    @item2 = Item.create({name: "Mediocre Coffee Product",
                          description: "It tastes fine",
                          unit_price: 12.49,
                          merchant_id: @merchant1.id
                          })
    @item3 = Item.create({name: "Eh at best Coffee Product",
                          description: "It tastes bad",
                          unit_price: 7.45,
                          merchant_id: @merchant2.id
                          })
  end

  it 'can get a merchants items' do
    get "/api/v1/merchants/#{@merchant1.id}/items"
    expect(response).to have_http_status(:success)
    items = JSON.parse(response.body)

    expect(items['data'].count).to eq(2)
    expect(items['data'].first['attributes']['name']).to eq(@item1.name)
    expect(items['data'].first['attributes']['description']).to eq(@item1.description)
    expect(items['data'].first['attributes']['unit_price']).to eq(@item1.unit_price.to_f)
  end

  it 'can_get an items merchant' do
    get "/api/v1/items/#{@item1.id}/merchant"
    expect(response).to have_http_status(:success)
    merchant = JSON.parse(response.body)

    expect(merchant['data']['attributes']['name']).to eq(@merchant1.name)
  end
end
