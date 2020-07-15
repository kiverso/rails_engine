class Merchant < ApplicationRecord
  has_many :invoices, dependent: :destroy
  has_many :items, dependent: :destroy
  extend Importable

  scope :search_by_name, -> (name) {where('name ILIKE ?', "%#{name}%")}
  scope :search_by_created_at, -> (created_at) {where("to_char(created_at, 'yyyy-mon-dd-HH-MI-SS')
                                                      ILIKE ?", "%#{created_at}%")}
  scope :search_by_updated_at, ->( updated_at) {where("TO_CHAR(updated_at,'yyyy-mon-dd-HH-MI-SS') 
                                                      ILIKE ?", "%#{updated_at}%")}
end
