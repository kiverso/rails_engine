class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice
  extend Importable
end
