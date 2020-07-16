class Merchant < ApplicationRecord
  has_many :invoices, dependent: :destroy
  has_many :items, dependent: :destroy
  validates_presence_of :name
  extend Importable

  scope :search_by_name, -> (name) {where('name ILIKE ?', "%#{name}%")}
  scope :search_by_created_at, -> (created_at) {where("to_char(created_at, 'yyyy-mon-dd-HH-MI-SS')
                                                      ILIKE ?", "%#{created_at}%")}
  scope :search_by_updated_at, ->( updated_at) {where("TO_CHAR(updated_at,'yyyy-mon-dd-HH-MI-SS') 
                                                      ILIKE ?", "%#{updated_at}%")}
  
  def self.aggregate_data(quantity)
    joins(invoices: [:invoice_items, :transactions])
    .where(transactions: {result: "success"})
    .group(:id)
    .limit(quantity)
  end

  def self.highest_revenue(quantity)
    aggregate_data(quantity)
    .select("merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue")
    .order('revenue DESC')
  end

  def self.most_items_sold(quantity)
    aggregate_data(quantity)
    .select("merchants.*, SUM(invoice_items.quantity) AS items_sold")
    .order('items_sold DESC')
  end

  def revenue
    invoices.joins(:invoice_items, :transactions)
    .where(transactions: {result: "success"})
    .sum('invoice_items.quantity*invoice_items.unit_price')
  end
end
