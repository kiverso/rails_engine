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
end

  # describe "GET /show" do
  #   it "returns http success" do
  #     get "/api/v1/items/show"
  #     expect(response).to have_http_status(:success)
  #   end
  # end


