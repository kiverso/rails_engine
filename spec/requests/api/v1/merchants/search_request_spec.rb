# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Merchants::Searches', type: :request do
  before(:each) do
    @merchant1 = Merchant.create({ name: 'Cool Merchant',
                                   created_at: 'Sat, 21 Dec 2019 01:30:11 UTC +00:00',
                                   updated_at: 'Sun, 22 Dec 2019 01:30:11 UTC +00:00' })
    @merchant2 = Merchant.create({ name: 'Neat Merchant' })
    @merchant3 = Merchant.create({ name: 'Cooler Merchant' })
    @merchant4 = Merchant.create({ name: 'Merchant 4',
                                   created_at: 'Sat, 21 Dec 2019 01:30:11 UTC +00:00',
                                   updated_at: 'Sun, 22 Dec 2019 01:30:11 UTC +00:00' })

    @merchant5 = Merchant.create({ name: 'Coolest Merchant',
                                   created_at: 'Sat, 21 Dec 2019 01:30:11 UTC +00:00',
                                   updated_at: 'Wed, 01 Jan 2020 01:30:11 UTC +00:00' })
  end

  describe 'GET /index' do
    it 'can get merchants based on name' do
      get '/api/v1/merchants/find_all?name=cool'
      expect(response).to have_http_status(:success)
      merchants = JSON.parse(response.body)
      expect(merchants['data'].length).to eq(3)
      expect(merchants['data'].first['attributes']['name']).to eq('Cool Merchant')
      expect(merchants['data'].last['attributes']['name']).to eq('Coolest Merchant')
    end

    it 'can get merchants based on created_at' do
      get '/api/v1/merchants/find_all?created_at=Dec'
      expect(response).to have_http_status(:success)
      merchants = JSON.parse(response.body)
      expect(merchants['data'].length).to eq(3)
      expect(merchants['data'].first['attributes']['name']).to eq('Cool Merchant')
      expect(merchants['data'].last['attributes']['name']).to eq('Coolest Merchant')
    end

    it 'can get merchants based on updated_at' do
      get '/api/v1/merchants/find_all?updated_at=Dec'
      expect(response).to have_http_status(:success)
      merchants = JSON.parse(response.body)
      expect(merchants['data'].length).to eq(2)
      expect(merchants['data'].first['attributes']['name']).to eq('Cool Merchant')
      expect(merchants['data'].last['attributes']['name']).to eq('Merchant 4')
    end

    it 'can get merchants based on multiple attributes' do
      get '/api/v1/merchants/find_all?name=cool&created_at=dec'
      expect(response).to have_http_status(:success)
      merchants = JSON.parse(response.body)
      expect(merchants['data'].length).to eq(2)
      expect(merchants['data'].first['attributes']['name']).to eq('Cool Merchant')
      expect(merchants['data'].last['attributes']['name']).to eq('Coolest Merchant')
    end
  end

  describe 'GET /show' do
    it 'can get merchants based on name' do
      get '/api/v1/merchants/find?name=cool'
      expect(response).to have_http_status(:success)
      merchants = JSON.parse(response.body)
      expect(merchants['data']['attributes']['name']).to eq('Cool Merchant')
    end

    it 'can get merchants based on created_at' do
      get '/api/v1/merchants/find?created_at=Dec'
      expect(response).to have_http_status(:success)
      merchants = JSON.parse(response.body)
      expect(merchants['data']['attributes']['name']).to eq('Cool Merchant')
    end

    it 'can get merchants based on updated_at' do
      get '/api/v1/merchants/find?updated_at=Dec'
      expect(response).to have_http_status(:success)
      merchants = JSON.parse(response.body)
      expect(merchants['data']['attributes']['name']).to eq('Cool Merchant')
    end

    it 'can get merchants based on multiple attributes' do
      get '/api/v1/merchants/find?name=cool&created_at=dec'
      expect(response).to have_http_status(:success)
      merchants = JSON.parse(response.body)
      expect(merchants['data']['attributes']['name']).to eq('Cool Merchant')
    end
  end
end
