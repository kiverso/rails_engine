require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it {should have_many(:items).dependent(:destroy)}
    it {should have_many(:invoices).dependent(:destroy)}
  end
end
