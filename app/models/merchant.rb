class Merchant < ApplicationRecord
  has_many :invoices, dependent: :destroy
  has_many :items, dependent: :destroy
  extend Importable

  scope :search_by_name, -> (name) {where('name ILIKE ?', "%#{name}%")}
  scope :search_by_created_at, -> (created_at) {where("to_char(created_at, 'yyyy-mon-dd-HH-MI-SS')
                                                      ILIKE ?", "%#{created_at}%")}
  scope :search_by_updated_at, ->( updated_at) {where("TO_CHAR(updated_at,'yyyy-mon-dd-HH-MI-SS') 
                                                      ILIKE ?", "%#{updated_at}%")}
  def self.highest_revenue(quantity)
    select("merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue")
    .joins(invoices: [:invoice_items, :transactions]).group(:id)
    .where(transactions: {result: "success"})
    .group(:id)
    .order('revenue DESC')
    .limit(quantity)
  end
end
