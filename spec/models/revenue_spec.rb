require 'rails_helper'

RSpec.describe Revenue, type: :model do
  describe 'Class Methods' do
    it "initialize" do
      revenue = Revenue.new(5.50)
      expect(revenue).to be_an_instance_of(Revenue)
      expect(revenue.id).to be_nil
      expect(revenue.revenue).to eq(5.50)
    end
  end
end
