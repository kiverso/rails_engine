require 'rails_helper'

RSpec.describe "Api::V1::Merchants", type: :request do
  before(:each) do
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)
    @merchant2 = create(:merchant)
    @merchant2 = create(:merchant)
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
end




