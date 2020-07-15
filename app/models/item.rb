class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items
  extend Importable

  scope :search_by_name, -> (name) {where('name ILIKE ?', "%#{name}%")}
  scope :search_by_description, -> (description) {where('description ILIKE ?', "%#{description}%")}
  scope :search_by_unit_price, -> (unit_price) {where("to_char(unit_price, '999999.99') ILIKE ?", "%#{unit_price}%")}
  scope :search_by_merchant_id, -> (merchant_id) {where("to_char(merchant_id, '9999999') ILIKE ?", "%#{merchant_id}%")}
  scope :search_by_created_at, -> (created_at) {where("to_char(created_at, 'yyyy-mon-dd-HH-MI-SS')
                                                      ILIKE ?", "%#{created_at}%")}
  scope :search_by_updated_at, ->( updated_at) {where("TO_CHAR(updated_at,'yyyy-mon-dd-HH-MI-SS') 
                                                      ILIKE ?", "%#{updated_at}%")}

end
