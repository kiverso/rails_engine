class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items
  has_many :transactions, dependent: :destroy
  extend Importable

  def self.revenue_between(start_date, end_date)
    joins(:invoice_items, :transactions)
    .where(transactions: {result: "success"},
    created_at: start_date..Date.parse(end_date).end_of_day)
    .sum('invoice_items.quantity*invoice_items.unit_price')
  end
end
