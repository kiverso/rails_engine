require 'rails_helper'

RSpec.describe "Business inteligence endpoints", type: :request do
  before(:each) do
    @customer = Customer.create({first_name: "Jeff", last_name: 'Lastname'})
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)
    @merchant3 = create(:merchant)
    @merchant4 = create(:merchant)

    @item1 = create(:item, unit_price: 9.99, merchant_id: @merchant1.id)
    @item2 = create(:item, unit_price: 1.99, merchant_id: @merchant2.id)
    @item3 = create(:item, unit_price: 7.99, merchant_id: @merchant3.id)
    @item4 = create(:item, unit_price: 16.99, merchant_id: @merchant4.id)

    @invoice1 = Invoice.create({customer_id: @customer.id, merchant_id: @merchant1.id, created_at: '2012-03-23 09:54:09 UTC'})
    @invoice2 = Invoice.create({customer_id: @customer.id, merchant_id: @merchant2.id, created_at: '2012-03-25 09:54:09 UTC'})
    @invoice3 = Invoice.create({customer_id: @customer.id, merchant_id: @merchant3.id, created_at: '2012-03-25 09:54:09 UTC'})
    @invoice4 = Invoice.create({customer_id: @customer.id, merchant_id: @merchant4.id, created_at: '2012-03-25 09:54:09 UTC'})
    @invoice5 = Invoice.create({customer_id: @customer.id, merchant_id: @merchant1.id, created_at: '2012-03-26 09:54:09 UTC'})

    @invoice_item1 = InvoiceItem.create({item_id: @item1.id, invoice_id: @invoice1.id, quantity: 1, unit_price: @item1.unit_price})
    @invoice_item2 = InvoiceItem.create({item_id: @item2.id, invoice_id: @invoice2.id, quantity: 7, unit_price: @item2.unit_price})
    @invoice_item3 = InvoiceItem.create({item_id: @item3.id, invoice_id: @invoice3.id, quantity: 1, unit_price: @item3.unit_price})
    @invoice_item4 = InvoiceItem.create({item_id: @item4.id, invoice_id: @invoice4.id, quantity: 1, unit_price: @item4.unit_price})
    @invoice_item5 = InvoiceItem.create({item_id: @item1.id, invoice_id: @invoice1.id, quantity: 1, unit_price: @item1.unit_price})

    @transaction1 = Transaction.create({invoice_id: @invoice1.id, result: 'success'})
    @transaction2 = Transaction.create({invoice_id: @invoice2.id, result: 'success'})
    @transaction3 = Transaction.create({invoice_id: @invoice3.id, result: 'success'})
    @transaction4 = Transaction.create({invoice_id: @invoice4.id, result: 'failed'})
    @transaction5 = Transaction.create({invoice_id: @invoice5.id, result: 'success'})
  end
  

  it 'returns the merchant with the highest revenue' do
    get '/api/v1/merchants/most_revenue?quantity=1'
    expect(response).to have_http_status(:success)
    merchants = JSON.parse(response.body)

    expect(merchants['data'].length).to eq(1)
    expect(merchants['data'].first['attributes']['name']).to eq(@merchant1.name)
  end

  it 'returns multiple merchants with the highest revenue' do
    get '/api/v1/merchants/most_revenue?quantity=3'
    expect(response).to have_http_status(:success)
    merchants = JSON.parse(response.body)

    expect(merchants['data'].length).to eq(3)
    expect(merchants['data'].first['attributes']['name']).to eq(@merchant1.name)
    expect(merchants['data'].last['attributes']['name']).to eq(@merchant3.name)
  end
end
